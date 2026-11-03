import 'package:auto_route/auto_route.dart';
import 'package:mockito/annotations.dart';
import 'package:refreshi_checkout/presentation/core/router/auth_guard.dart';
import 'package:refreshi_checkout/infrastructure/core/id_generator.dart';
import 'package:refreshi_checkout/infrastructure/auth/auth_local_data_source.dart';
import 'package:refreshi_checkout/domain/auth/auth_repository.dart';
import 'package:refreshi_checkout/application/auth/get_current_session.dart';
import 'package:refreshi_checkout/application/auth/sign_in.dart';
import 'package:refreshi_checkout/application/auth/sign_out.dart';
import 'package:refreshi_checkout/infrastructure/catalog/catalog_remote_data_source.dart';
import 'package:refreshi_checkout/domain/catalog/catalog_repository.dart';
import 'package:refreshi_checkout/application/catalog/get_checkout_catalog.dart';
import 'package:refreshi_checkout/infrastructure/checkout/checkout_local_data_source.dart';
import 'package:refreshi_checkout/domain/checkout/checkout_repository.dart';
import 'package:refreshi_checkout/application/checkout/load_checkout_draft.dart';
import 'package:refreshi_checkout/application/checkout/save_checkout_draft.dart';
import 'package:refreshi_checkout/application/checkout/start_new_checkout.dart';
import 'package:refreshi_checkout/application/checkout/submit_checkout.dart';
import 'package:refreshi_checkout/infrastructure/orders/order_remote_data_source.dart';
import 'package:refreshi_checkout/domain/orders/order_repository.dart';
import 'package:refreshi_checkout/application/orders/create_order.dart';
import 'package:refreshi_checkout/application/orders/get_order.dart';
import 'package:refreshi_checkout/application/orders/watch_order.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// One place for every mockito mock, so `build_runner` generates them once.
@GenerateNiceMocks([
  // Data sources
  MockSpec<AuthLocalDataSource>(),
  MockSpec<CatalogRemoteDataSource>(),
  MockSpec<CheckoutLocalDataSource>(),
  MockSpec<OrderRemoteDataSource>(),
  // Repositories
  MockSpec<AuthRepository>(),
  MockSpec<CatalogRepository>(),
  MockSpec<CheckoutRepository>(),
  MockSpec<OrderRepository>(),
  // Use cases
  MockSpec<GetCurrentSession>(),
  MockSpec<SignIn>(),
  MockSpec<SignOut>(),
  MockSpec<GetCheckoutCatalog>(),
  MockSpec<LoadCheckoutDraft>(),
  MockSpec<SaveCheckoutDraft>(),
  MockSpec<StartNewCheckout>(),
  MockSpec<SubmitCheckout>(),
  MockSpec<CreateOrder>(),
  MockSpec<GetOrder>(),
  MockSpec<WatchOrder>(),
  // Infrastructure
  MockSpec<IdGenerator>(),
  MockSpec<SharedPreferences>(),
  MockSpec<AuthGuard>(),
  MockSpec<NavigationResolver>(),
  MockSpec<StackRouter>(),
])
void main() {}
