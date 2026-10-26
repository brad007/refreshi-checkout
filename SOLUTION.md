# Solution

## Stack

| Concern | Choice |
| --- | --- |
| Architecture | Clean Architecture, split by feature into `data`, `domain` and `presentation` layers, built test-first. Use cases are the only way into the domain. |
| State | `flutter_bloc`, with `bloc_concurrency` transformers |
| DI | `get_it` + `injectable` |
| Routing | `auto_route` (declarative, path-based, with guards) |
| Models | `freezed` for entities, events, states and failures; `json_serializable` for persisted models |
| Errors | `fpdart` `Either<Failure, T>` from repositories up |
| GraphQL | `graphql` client with `graphql_codegen` typed operations |
| Payments | Peach Payments (simulated, modelled on their server-to-server API) |
| Tests | `flutter_test`, `bloc_test`, `mockito`, `fake_async` |

**Changed from the requested stack:**

- **`dartz` was dropped.** `fpdart` does the same job (`Either`, `Option`, `Unit`) and is maintained for Dart 3. Using both means two incompatible `Either` types and import clashes in every file. Repositories still return `Either<Failure, T>`, so the architecture is unchanged.
- **`graphql_codegen` instead of `ferry`.** `ferry_generator` currently pins an `analyzer` range that conflicts with `injectable_generator` 3.x, so the two can't be installed together. `graphql_codegen` produces fully typed operation, variable and fragment classes for the `graphql` client, so app code never touches a `Map`.

## Architecture

```
UI (pages, widgets)
  └─ Bloc ─── events in, freezed states out
       └─ UseCase ─── one action, returns Either<Failure, T> or Stream<Either<…>>
            └─ Repository (contract in domain, impl in data)
                 └─ DataSource ─── throws ServerException / NetworkException / CacheException
                      └─ GraphQLClient (typed, generated) ─ LocalGraphQLLink ─ in-app backend
                      └─ SharedPreferences
```

- **Domain entities are free of transport types.** The generated GraphQL classes act as the data-layer models. Mapper extensions (`toEntity()`) convert them, so nothing above `data/` imports generated code.
- **Errors are values.** Data sources throw typed exceptions. One function (`mapExceptionToFailure`) turns them into a sealed `Failure` union. Blocs switch over failures exhaustively and each failure has a `userMessage`.
- **DI.** Every repository, data source and use case is `@LazySingleton(as: Contract)`. App-wide blocs (`AuthBloc`, `CatalogBloc`, `CheckoutBloc`) are singletons exposed with `BlocProvider.value`. `OrderDetailsBloc` is a factory, one per page. Tests swap anything by constructing classes with mocks or by re-registering in `getIt`.

## Routing and deep links

- Path URL strategy, so `/orders/ord_abc` is a real, shareable URL.
- `/checkout` and `/orders/:orderId` sit behind `AuthGuard`. Signed-out users go to `/sign-in?redirect=/orders/ord_abc`. **The destination lives in the URL, not in memory,** so refreshing the sign-in page still returns you to the right place. The redirect is sanitised (`safeRedirectPath`) to block open redirects such as `?redirect=https://evil.example`.
- Every page rebuilds its state from the URL plus persisted data. The order page fetches by id, so a cold deep link and a refresh behave the same.
- After an order is placed, checkout is **replaced** by the order route, so browser Back doesn't land on a spent checkout.

## Typed GraphQL without a server

- `lib/core/graphql/schema.graphql` is the API contract. Operations live with their feature (`features/*/data/graphql/*.graphql`). `graphql_codegen` validates them against the schema at build time and generates types.
- The client is a normal `GraphQLClient`. The only difference from production is its terminating link: `LocalGraphQLLink` runs operations in-process. Swapping it for an `HttpLink` would point the app at a real server.
- `LocalGraphQLExecutor` is a deliberately small executor. Root-field resolvers return JSON-like objects, and the executor projects them onto the request's selection set, handling aliases, fragment spreads, inline fragments, variables and defaults. Responses therefore have exactly the shape the generated parsers expect. Resolver errors become GraphQL errors with `extensions.code`, as a real server would send.
- `LocalCheckoutBackend` holds the business rules: validation, idempotent order creation and the simulated payment hold. Its store writes through to `localStorage`, so orders survive refresh like server data would. Pending holds are re-armed on startup with their original due time.

## Payments: Peach Payments

Refreshi is a South African business, so the payment provider is **Peach Payments**. The brief asks for no backend service and no real payment processing, so Peach is simulated inside the in-app backend (`core/graphql/local/peach/`). The simulation is modelled closely on Peach's documented server-to-server API:

| Peach concept | How the app uses it |
| --- | --- |
| Registration token (`/v1/registrations`) | A saved card is a 32-hex registration id plus brand and last four digits. No card data is ever in the app. Visa •••• 0000 and Mastercard •••• 5454 are Peach's published test cards. |
| `POST /v1/registrations/{id}/payments`, `paymentType=PA` | Placing an order requests a **pre-authorisation**: the "temporary hold" from the brief. Amounts are sent as Peach formats them (`"154.00"`), in `ZAR`. |
| Result codes `ddd.ddd.ddd` | The pre-auth returns `000.200.000` (pending). The final status is `000.100.110` (success in Integrator Test Mode) or `800.100.203` (Insufficient Funds) for the decline card. `PeachResultCode` classifies codes with Peach's published patterns into success, success-needs-review, pending and rejected. |
| `PAYMENT` webhook | The final status arrives asynchronously as a webhook. Peach warns that webhooks may be resent and arrive out of order, so the backend applies **only the first final status** for a pending hold and ignores the rest. |
| `CP` / `RV` | Capture at pickup and reversal for no-shows are noted in the UI copy but not implemented: out of scope for this slice. |

**Why the app never talks to Peach directly.** A real integration needs the merchant's Bearer token and entity id, and must receive encrypted webhooks (AES-256-GCM). Both have to live on a server. In this design `LocalCheckoutBackend` plays that server, and `PeachPaymentsSimulator` is where an HTTP client for `sandbox-card.peachpayments.com` would go. The Flutter app only sees the GraphQL `PaymentHold` (`provider`, `paymentType`, `reference`, `resultCode`, `resultDescription`), which the order page shows for support and reconciliation.

**Idempotency still guards the money.** A Peach pre-authorisation is only requested when an order is *created*. A replayed request returns the original order and never calls Peach again, so a double click or a refresh can't place a second hold on the card.

**Async hold confirmation** uses a GraphQL **subscription**, `orderUpdated(id)`. It emits the current snapshot first, then each change, and completes once the order is final. The backend subscribes to changes *before* emitting the snapshot, so no update can slip between them. The order page fetches with the `OrderDetails` query and subscribes only while the hold is pending.

## Preventing duplicate financial outcomes

Protection is layered, so no single layer has to be perfect:

1. **UI.** The Confirm button is disabled and shows a spinner while submitting. Inputs are disabled too.
2. **Bloc.** `CheckoutSubmitted` uses the `droppable()` transformer, so repeated events are dropped while one is running. Draft edits are ignored while submitting, so the request can't change underneath.
3. **Idempotency key (the real guarantee).** Each checkout draft gets a UUID when it is created. Every attempt to place that order sends the same key.
   - Backend: the check-and-insert on the key runs synchronously before the first `await`, so two requests in the same frame can't both create an order. The same key with the same payload **replays** the original order (`replayed: true`). The same key with a *different* payload is **rejected** (`IDEMPOTENCY_KEY_REUSED`, with the original order id). Silently returning the old order for a different request would be wrong.
   - After success the draft is replaced with a new one and a new key, so the next checkout is a new order.
4. **Refresh mid-submit.** Just before the request is sent, the draft is saved with `submissionInFlight: true`. If the page reloads, the outcome is unknown: the request may or may not have reached the backend. On startup, `CheckoutBloc` sees the flag and **resubmits with the same key**. The backend either creates the order or replays it, so either way the customer lands on exactly one order. To make this case real, the backend stores the order before its simulated response latency.

**Trade-offs**

- The key is tied to the draft, not to its contents. If a submission's outcome is unknown and the customer then *changes* the cart, the retry is rejected, not turned into a second order. The UI then offers "View that order" or "Start a new checkout". I chose to never double-charge over never blocking.
- Everything lives in one browser profile. Two tabs share `localStorage` and the backend's synchronous check is per tab, so two tabs submitting in the same instant aren't fully covered. A real server with a unique constraint on the key would cover it.
- The draft is in `localStorage`, not `sessionStorage`, so it survives closing the tab. That suits a cart, but it means the in-flight retry can fire on a later visit. That is still safe because of the key.

## Design

The first version used stock Material components and looked generic. The redesign takes refreshi.co.za's actual design language, read from the site's CSS tokens rather than guessed:

- **Palette:** cream `#F6F3EE` background, forest `#1E3024` for ink and primary, lime `#E9F44D` as the accent on forest, orange `#FF7517` for prices and highlights, sage `#C7D1CC` for borders.
- **Type:** **Clash Display** for headlines and numbers, **DM Sans** for body text, the site's own pairing. Both are bundled under `assets/fonts` with their licences (SIL OFL and ITF Free Font License).
- **Signature moves from the site:** stacked multi-colour headlines ("Rescue food. / Pay less. / Waste nothing."), pill buttons, a frosted pill nav bar, and forest panels with half-disc shapes that echo the logo mark.
- **Product-specific UI rather than generic cards:**
  - Bags read like price tags: store, contents, an orange price with the struck-through shelf value, and a lime "-67%".
  - The checkout summary is a till receipt with dashed rules and a torn edge.
  - Saved cards look like cards.
  - The order page leads with a status headline and a pickup ticket.
- **Content matches the business:** Refreshi sells surplus food, so the brief's "services" are rescue bags and the time slots are pickup windows. The flow and the duplicate protection are unchanged.
- **Motion:** a short staggered entrance and animated selection states. Both respect the platform's reduced-motion setting.
- **Light theme only**, like the site: its forest panels and cream surfaces lose their contrast in a dark variant.
- **UX pass on the finished app:** a full run-through as a new visitor, on desktop and phone, found 14 issues, all fixed:
  - Explain why bags grey out at the limit; say what's missing while "Reserve" is disabled.
  - Give signed-out visitors a "Sign in" button; add back links; clear stale form errors as the user types.
  - Keep the receipt in view on desktop, and give phones a sticky reserve bar.
  - Lay out pickup times and cards two per row on phones.
  - Turn a declined payment into a one-tap **Try another card**, which keeps the same bags and window and uses a new idempotency key.
- **Accessibility and edge-state pass:**
  - **Contrast:** brand orange is 2.4:1 on cream, so text and icons on light backgrounds use a darker "orange ink" (`#B84A05`, 4.7:1). Bright orange stays for fills and for text on forest.
  - **Keyboard:** saved cards are focusable, every control has a visible focus ring, and a full keyboard-only checkout works.
  - **Large text:** every screen is tested at 1.5× and 2× text, on phone and desktop, with no overflow. Fixed-height chrome caps text scaling at 1.3×.
  - **Screen readers:** the order status headline is a live region, so the bank's answer is announced.
  - **Mouse:** day tiles fit on one row, or can be dragged with a mouse.
  - **Edge states:** loading uses a skeleton. A missing order offers no pointless "Try again". A conflicted checkout is treated as spent, so it can't loop on the same error.

## Robustness details

- Saved selections that are no longer offered (a slot that has passed, a removed card) are dropped when the catalog loads.
- Unknown enum values from a newer server (`$unknown`) map to the safest state, e.g. "pending", rather than crashing.
- Corrupt persisted data falls back to empty instead of failing startup.
- Money is integer cents throughout and formatted with `intl` (ZAR).

## Optional item: tests

I chose **tests** over a web performance tweak, and went beyond the single test the brief asks for, because the core requirement (no duplicate financial outcomes) is about correctness under timing. That is easy to break and hard to see by hand.

- 289 tests; over 99% line coverage of hand-written `lib/` code.
- The Peach simulator and result-code classification have their own tests, including duplicate and out-of-order webhooks.
- Domain and data layers use mockito mocks for every collaborator.
- Data sources are tested against the **real** local GraphQL stack, which exercises generated documents, the executor and the parsers end to end.
- Bloc tests cover the double-submit and resume-after-reload paths.
- `test/flows` boots the real app (router, guard and blocs) with mocked use cases and drives it like a user would: deep links while signed out, refreshed sign-in, double click, resumed submission, idempotency conflict, live hold update and phone layouts.

The tests found real bugs that manual testing in a release web build had missed:

- **Subscription covariance crash.** The subscription resolver returned `Stream<Map<…>>`, and calling `transform` with a `StreamTransformer<Object?, …>` failed Dart's runtime covariance check. Release web builds skip that check, so it only failed in the VM.
- **Phone-width overflows** on the catalog bar and the order details rows.
- **A race on resume.** If the resumed submission finished before the checkout page mounted, the page never navigated to the order.
- **Overflow risks after the redesign:** long emails in the nav bar, long card-brand names, and the price row on narrow cards. All now truncate or flex.

## What I'd do next

- Introduce an `HttpLink` behind an environment flag and move `LocalCheckoutBackend` into a test fixture.
- Add golden tests for the timeline states and an integration test on a real browser via `integration_test`.
- Web performance: defer-load the checkout and order routes (`deferredLoading: true` in auto_route) and try a `--wasm` build.

## AI usage

- **Tool:** Claude Code (Claude Opus 5.5), in the Claude desktop app.
- **Where in the workflow:**
  - *Planning:* summarising the brief and proposing an architecture. The developer fixed the stack: freezed, get_it, injectable, auto_route, fpdart/dartz, a feature-first Clean Architecture built test-first, mockito, and "always write tests, keep coverage high".
  - *Implementation:* the AI wrote the schema, the local executor and backend, the feature layers, the UI, the tests and these docs.
  - *Debugging:* the AI ran the analyzer, the test suite and the app in a browser, and fixed what it found.
  - *Demo video:* the AI scripted and recorded the screen footage (headless Chrome over the DevTools protocol), rendered the code slides from the real source, and drafted the narration script. The voice-over is my own recording; the AI cleaned the audio and timed the video to it.
- **Accepted, changed, rejected:**
  - *Rejected:* `ferry` for GraphQL, the AI's first suggestion. `pub get` showed that `ferry_generator`'s analyzer constraint conflicts with `injectable_generator` 3.x. Switched to `graphql_codegen`.
  - *Changed:* the stack asked for both `dartz` and `fpdart`. They define clashing `Either`/`Option`/`Unit` types, so only `fpdart` was kept. The entity was also renamed from `Order` to `CustomerOrder` because `Order` clashes with types in `fpdart` and `injectable`.
  - *Changed:* the first version of the subscription tests used `fake_async`, which never delivered the stream's done event. Those tests were moved to real time with millisecond delays.
  - *Accepted after a test caught it:* the covariance fix in `LocalGraphQLExecutor`, which needed `.cast<Object?>()` before `transform`.
  - *Rejected:* the first visual pass, which only recoloured stock Material widgets. The developer called it "vibe coded", so the screens were redesigned around Refreshi's real tokens and fonts, read from refreshi.co.za.
  - *Researched, then changed:* bundling Clash Display in the repo. Its licence (ITF FFL) forbids redistribution through a repository, so the files are not committed and `tool/fetch_fonts.sh` downloads them from Fontshare.
  - *Researched, then applied:* the Peach Payments details (endpoints, `PA`/`CP`/`RV`, result codes and their regexes, webhook format) came from an AI-driven read of developer.peachpayments.com, not from memory. Peach publishes no decline test card, so the decline token is the simulator's own invention and is labelled as such.
- **Verification:**
  - `flutter analyze` is clean.
  - `flutter test --coverage` passes: 289 tests.
  - After the redesign: a manual run of the full flow in a release build. The order page showed Peach `000.100.110` arriving by webhook, and the phone layout was checked separately.
  - Manual browser run of a release build behind a server that falls back to `index.html`. Checked: catalog → sign-in redirect → refresh on `/sign-in?redirect=/checkout` → checkout → double-click Confirm. `localStorage` showed exactly **one** order and one idempotency key, and the draft had rotated to a new key. Pending → Confirmed live update. Signed-out deep link → sign-in → back to the order. A draft forced to `submissionInFlight: true` → reload → one order. The same again with the same key → the same order id (replayed, not duplicated).
