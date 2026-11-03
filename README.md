# Refreshi checkout

A web-first checkout slice in Flutter, styled after [refreshi.co.za](https://refreshi.co.za/). Customers pick one or two surplus-food "rescue bags" from partner stores, choose a pickup window and a saved card, and place an order. The order puts a hold on the card through **Peach Payments** (simulated) as a pre-authorisation. The order page shows the hold as pending, then updates live when Peach confirms it.

The same codebase runs on iOS and Android. There is no backend service: the GraphQL schema lives in the repo and an in-app backend resolves it.

**Demo video (5 min, voice-over):** [docs/demo.mp4](docs/demo.mp4)

See [SOLUTION.md](SOLUTION.md) for design decisions and trade-offs.

## Requirements

- Flutter **3.47** (stable) / Dart **3.13**, the versions this was built and tested with. The current releases of `freezed`, `json_serializable` and `injectable_generator` need Dart 3.12 or newer, so older Flutter versions won't resolve the dev dependencies.
- Chrome for web. Xcode or Android Studio for mobile.

## Run it

The quickest way is the Makefile. Run `make` to list every command.

```bash
make web
```

That downloads the headline font if needed, fetches packages and runs the app in Chrome with hot reload.

**There's no separate backend to start.** The GraphQL API (schema resolvers, idempotency rules, order store) and the Peach Payments simulator run inside the app, in `lib/infrastructure/core/graphql/local/`, and start with it.

| Command | What it does |
| --- | --- |
| `make setup` | First-time setup: downloads Clash Display from Fontshare (its licence doesn't allow it in a repository) and runs `flutter pub get` |
| `make web` | Chrome, with hot reload |
| `make serve` | Release web build at http://localhost:8686, served so deep links and refresh work (`PORT=...` to change) |
| `make ios` / `make android` | iOS Simulator / a running Android emulator |
| `make run DEVICE=...` | Any device from `make devices` |
| `make codegen` | Regenerates GraphQL types, freezed, injectable, routes and mocks. Generated code is committed, so you only need this after changing a `.graphql` file or an annotated class. |
| `make check` | `flutter analyze`, then `flutter test` |
| `make coverage` | Tests with coverage (`coverage/lcov.info`) |

`make serve` uses `tool/serve_web.py`, a static server that falls back to `index.html`. The app uses path URLs (`/orders/ord_123`), and a plain static server would 404 on refresh. Production hosting needs the same rewrite rule.

## Try these

| Scenario | How |
| --- | --- |
| Happy path | Add bags → **Continue to checkout** → sign in with any email → choose a pickup window and **Visa •••• 0000** → **Reserve & place hold**. The order page shows *Pending* (Peach `000.200.000`), then *Confirmed* about 3 s later (Peach `000.100.110`). |
| Declined hold | Pay with **Visa •••• 8079**. Peach returns `800.100.203 Insufficient Funds` and the timeline shows the decline. |
| Double click | Double-click the reserve button. Only one order and one Peach pre-authorisation are created. |
| Deep link while signed out | Sign out, then paste an order URL. You go to sign-in and then back to that order. |
| Refresh anywhere | Refresh on `/checkout`, `/sign-in?redirect=…` or `/orders/…`. You keep your place. |
| Refresh mid-submit | Click **Reserve & place hold** and refresh straight away. The app resubmits with the same idempotency key and lands on the single order. |

Orders, the session and the checkout draft are stored in `localStorage` (via `shared_preferences`). To reset, clear site data.

## Payments: Peach Payments (simulated)

The brief asks for no backend service, so Peach is simulated inside the in-app backend (`lib/infrastructure/core/graphql/local/peach/`). The simulation follows Peach's documented server-to-server API:

- Saved cards are Peach **registration tokens**. The app only ever sees the token and the last four digits. Visa •••• 0000 and Mastercard •••• 5454 are Peach's published test cards; •••• 8079 simulates a decline.
- Placing an order requests a **pre-authorisation** (`paymentType=PA`) on the token, i.e. `POST /v1/registrations/{id}/payments`, with the amount as a string (`"154.00"`) in ZAR.
- Peach answers **pending** (`000.200.000`) at once. The final status arrives later as a `PAYMENT` **webhook**, and is classified with Peach's own result-code patterns.

## Design

The theme follows refreshi.co.za's tokens: cream `#F6F3EE`, forest `#1E3024`, lime `#E9F44D` and orange `#FF7517`, with pill controls, a frosted pill nav, **Clash Display** headlines and **DM Sans** body text. DM Sans is committed in `assets/fonts`; Clash Display is downloaded by `tool/fetch_fonts.sh`. See `assets/fonts/LICENSES.md`. The app is light-only, like the site.

## Tests

```bash
flutter test
```

To measure coverage:

```bash
flutter test --coverage
```

The suite has 289 tests in 39 files: unit tests for every layer, bloc tests, data-source tests that run against the real in-app GraphQL stack, and widget tests that drive the real router, guard and blocs with mocked use cases. Line coverage of hand-written code in `lib/` is above 99%, excluding generated files. `main.dart` is not counted because tests don't load it.

## Project layout

Layered, DDD-style. Dependencies point inward only: `presentation` → `application` → `domain` ← `infrastructure`.

```
lib/
  domain/          entities, repository contracts, Failure: pure Dart, no Flutter
    core/ auth/ catalog/ checkout/ orders/
  application/     use cases and the blocs that orchestrate them
    core/ auth/ catalog/ checkout/ orders/
  infrastructure/  repository impls, data sources, DTO mappers, *.graphql operations
    core/          exceptions → failures, DI module, typed GraphQL client
      graphql/
        schema.graphql     source of truth for the API
        local/             in-app backend: executor, resolvers, store, Link
          peach/           Peach Payments simulator and result codes
    auth/ catalog/ checkout/ orders/
  presentation/    pages, widgets, router + AuthGuard, theme, formatters
    core/ auth/ catalog/ checkout/ orders/
  injection.dart   composition root (get_it + injectable)
  main.dart
test/              mirrors lib/, plus test/flows for end-to-end widget tests
```
