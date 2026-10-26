import 'package:auto_route/auto_route.dart';
import 'package:mockito/annotations.dart';
import 'package:refreshi_checkout/core/router/auth_guard.dart';
import 'package:refreshi_checkout/core/utils/id_generator.dart';
import 'package:refreshi_checkout/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:refreshi_checkout/features/auth/domain/repositories/auth_repository.dart';
import 'package:refreshi_checkout/features/auth/domain/usecases/get_current_session.dart';
import 'package:refreshi_checkout/features/auth/domain/usecases/sign_in.dart';
import 'package:refreshi_checkout/features/auth/domain/usecases/sign_out.dart';
import 'package:refreshi_checkout/features/catalog/data/datasources/catalog_remote_data_source.dart';
import 'package:refreshi_checkout/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:refreshi_checkout/features/catalog/domain/usecases/get_checkout_catalog.dart';
import 'package:refreshi_checkout/features/checkout/data/datasources/checkout_local_data_source.dart';
import 'package:refreshi_checkout/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:refreshi_checkout/features/checkout/domain/usecases/load_checkout_draft.dart';
import 'package:refreshi_checkout/features/checkout/domain/usecases/save_checkout_draft.dart';
import 'package:refreshi_checkout/features/checkout/domain/usecases/start_new_checkout.dart';
import 'package:refreshi_checkout/features/checkout/domain/usecases/submit_checkout.dart';
import 'package:refreshi_checkout/features/orders/data/datasources/order_remote_data_source.dart';
import 'package:refreshi_checkout/features/orders/domain/repositories/order_repository.dart';
import 'package:refreshi_checkout/features/orders/domain/usecases/create_order.dart';
import 'package:refreshi_checkout/features/orders/domain/usecases/get_order.dart';
import 'package:refreshi_checkout/features/orders/domain/usecases/watch_order.dart';
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
