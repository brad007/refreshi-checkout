# Refreshi checkout

A web-first checkout slice in Flutter, styled after [refreshi.co.za](https://refreshi.co.za/). Customers pick one or two surplus-food "rescue bags" from partner stores, choose a pickup window and a saved card, and place an order. The order puts a hold on the card through **Peach Payments** (simulated) as a pre-authorisation. The order page shows the hold as pending, then updates live when Peach confirms it.

The same codebase runs on iOS and Android. There is no backend service: the GraphQL schema lives in the repo and an in-app backend resolves it.

See [SOLUTION.md](SOLUTION.md) for design decisions and trade-offs.

## Requirements

- Flutter **3.47** (stable) / Dart **3.13**, the versions this was built and tested with. The current releases of `freezed`, `json_serializable` and `injectable_generator` need Dart 3.12 or newer, so older Flutter versions won't resolve the dev dependencies.
- Chrome for web. Xcode or Android Studio for mobile.

## Run it

Download the headline font first. Clash Display's licence doesn't allow it to be redistributed through a repository, so each developer fetches their own copy from Fontshare:

```bash
./tool/fetch_fonts.sh
```

```bash
flutter pub get
```

Generated code (GraphQL types, freezed, injectable, auto_route, mocks) is committed, so the app runs straight away. To regenerate it after changing a `.graphql` file or an annotated class:

```bash
dart run build_runner build
```

### Web

```bash
flutter run -d chrome
```

The app uses path URLs (`/orders/ord_123`, not `/#/orders/ord_123`). `flutter run` serves every path, so deep links and refresh work in development. For a production build, the host must rewrite unknown paths to `index.html`:

```bash
flutter build web --release
```

### Mobile

```bash
flutter run -d ios
```

```bash
flutter run -d android
```

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

The brief asks for no backend service, so Peach is simulated inside the in-app backend (`lib/core/graphql/local/peach/`). The simulation follows Peach's documented server-to-server API:

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

```
lib/
  core/
    di/            get_it + injectable setup and the third-party module
    error/         exceptions (data layer), failures (domain), the mapping between them
    graphql/
      schema.graphql       source of truth for the API
      local/               in-app backend: executor, resolvers, store, Link
        peach/             Peach Payments simulator and result codes
    router/        auto_route config, AuthGuard, redirect sanitising
    usecase/       UseCase / StreamUseCase base types
    utils/ theme/ widgets/
  features/
    auth/ catalog/ checkout/ orders/
      data/        datasources, models/mappers, repository implementations, *.graphql operations
      domain/      entities, repository contracts, use cases
      presentation/ blocs, pages, widgets
test/              mirrors lib/, plus test/flows for end-to-end widget tests
```
