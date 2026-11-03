// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:graphql/client.dart' as _i763;
import 'package:injectable/injectable.dart' as _i526;
import 'package:refreshi_checkout/application/auth/auth_bloc.dart' as _i989;
import 'package:refreshi_checkout/application/auth/get_current_session.dart'
    as _i56;
import 'package:refreshi_checkout/application/auth/sign_in.dart' as _i887;
import 'package:refreshi_checkout/application/auth/sign_out.dart' as _i66;
import 'package:refreshi_checkout/application/catalog/catalog_bloc.dart'
    as _i800;
import 'package:refreshi_checkout/application/catalog/get_checkout_catalog.dart'
    as _i392;
import 'package:refreshi_checkout/application/checkout/checkout_bloc.dart'
    as _i537;
import 'package:refreshi_checkout/application/checkout/load_checkout_draft.dart'
    as _i648;
import 'package:refreshi_checkout/application/checkout/save_checkout_draft.dart'
    as _i1037;
import 'package:refreshi_checkout/application/checkout/start_new_checkout.dart'
    as _i1023;
import 'package:refreshi_checkout/application/checkout/submit_checkout.dart'
    as _i637;
import 'package:refreshi_checkout/application/orders/create_order.dart'
    as _i394;
import 'package:refreshi_checkout/application/orders/get_order.dart' as _i886;
import 'package:refreshi_checkout/application/orders/order_details_bloc.dart'
    as _i293;
import 'package:refreshi_checkout/application/orders/watch_order.dart' as _i601;
import 'package:refreshi_checkout/domain/auth/auth_repository.dart' as _i702;
import 'package:refreshi_checkout/domain/catalog/catalog_repository.dart'
    as _i448;
import 'package:refreshi_checkout/domain/checkout/checkout_repository.dart'
    as _i432;
import 'package:refreshi_checkout/domain/orders/order_repository.dart' as _i590;
import 'package:refreshi_checkout/infrastructure/auth/auth_local_data_source.dart'
    as _i819;
import 'package:refreshi_checkout/infrastructure/auth/auth_repository_impl.dart'
    as _i159;
import 'package:refreshi_checkout/infrastructure/catalog/catalog_remote_data_source.dart'
    as _i291;
import 'package:refreshi_checkout/infrastructure/catalog/catalog_repository_impl.dart'
    as _i939;
import 'package:refreshi_checkout/infrastructure/checkout/checkout_local_data_source.dart'
    as _i59;
import 'package:refreshi_checkout/infrastructure/checkout/checkout_repository_impl.dart'
    as _i346;
import 'package:refreshi_checkout/infrastructure/core/graphql/local/local_backend_store.dart'
    as _i1048;
import 'package:refreshi_checkout/infrastructure/core/graphql/local/local_checkout_backend.dart'
    as _i326;
import 'package:refreshi_checkout/infrastructure/core/id_generator.dart'
    as _i447;
import 'package:refreshi_checkout/infrastructure/core/register_module.dart'
    as _i317;
import 'package:refreshi_checkout/infrastructure/orders/order_remote_data_source.dart'
    as _i928;
import 'package:refreshi_checkout/infrastructure/orders/order_repository_impl.dart'
    as _i842;
import 'package:refreshi_checkout/presentation/core/router/app_router.dart'
    as _i342;
import 'package:refreshi_checkout/presentation/core/router/auth_guard.dart'
    as _i260;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:uuid/uuid.dart' as _i706;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i706.Uuid>(() => registerModule.uuid);
    gh.lazySingleton<_i447.IdGenerator>(
      () => _i447.IdGenerator(gh<_i706.Uuid>()),
    );
    gh.lazySingleton<_i819.AuthLocalDataSource>(
      () => _i819.AuthLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i59.CheckoutLocalDataSource>(
      () => _i59.CheckoutLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i1048.LocalBackendStore>(
      () => registerModule.backendStore(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i326.LocalCheckoutBackend>(
      () => registerModule.backend(
        gh<_i1048.LocalBackendStore>(),
        gh<_i447.IdGenerator>(),
      ),
    );
    gh.lazySingleton<_i763.GraphQLClient>(
      () => registerModule.graphQLClient(gh<_i326.LocalCheckoutBackend>()),
    );
    gh.lazySingleton<_i928.OrderRemoteDataSource>(
      () => _i928.OrderRemoteDataSourceImpl(gh<_i763.GraphQLClient>()),
    );
    gh.lazySingleton<_i432.CheckoutRepository>(
      () => _i346.CheckoutRepositoryImpl(
        gh<_i59.CheckoutLocalDataSource>(),
        gh<_i447.IdGenerator>(),
      ),
    );
    gh.lazySingleton<_i291.CatalogRemoteDataSource>(
      () => _i291.CatalogRemoteDataSourceImpl(gh<_i763.GraphQLClient>()),
    );
    gh.lazySingleton<_i702.AuthRepository>(
      () => _i159.AuthRepositoryImpl(gh<_i819.AuthLocalDataSource>()),
    );
    gh.lazySingleton<_i590.OrderRepository>(
      () => _i842.OrderRepositoryImpl(gh<_i928.OrderRemoteDataSource>()),
    );
    gh.lazySingleton<_i394.CreateOrder>(
      () => _i394.CreateOrder(gh<_i590.OrderRepository>()),
    );
    gh.lazySingleton<_i886.GetOrder>(
      () => _i886.GetOrder(gh<_i590.OrderRepository>()),
    );
    gh.lazySingleton<_i601.WatchOrder>(
      () => _i601.WatchOrder(gh<_i590.OrderRepository>()),
    );
    gh.lazySingleton<_i637.SubmitCheckout>(
      () => _i637.SubmitCheckout(
        gh<_i432.CheckoutRepository>(),
        gh<_i394.CreateOrder>(),
      ),
    );
    gh.lazySingleton<_i56.GetCurrentSession>(
      () => _i56.GetCurrentSession(gh<_i702.AuthRepository>()),
    );
    gh.lazySingleton<_i887.SignIn>(
      () => _i887.SignIn(gh<_i702.AuthRepository>()),
    );
    gh.lazySingleton<_i66.SignOut>(
      () => _i66.SignOut(gh<_i702.AuthRepository>()),
    );
    gh.lazySingleton<_i648.LoadCheckoutDraft>(
      () => _i648.LoadCheckoutDraft(gh<_i432.CheckoutRepository>()),
    );
    gh.lazySingleton<_i1037.SaveCheckoutDraft>(
      () => _i1037.SaveCheckoutDraft(gh<_i432.CheckoutRepository>()),
    );
    gh.lazySingleton<_i1023.StartNewCheckout>(
      () => _i1023.StartNewCheckout(gh<_i432.CheckoutRepository>()),
    );
    gh.lazySingleton<_i448.CatalogRepository>(
      () => _i939.CatalogRepositoryImpl(gh<_i291.CatalogRemoteDataSource>()),
    );
    gh.factory<_i293.OrderDetailsBloc>(
      () =>
          _i293.OrderDetailsBloc(gh<_i886.GetOrder>(), gh<_i601.WatchOrder>()),
    );
    gh.lazySingleton<_i537.CheckoutBloc>(
      () => _i537.CheckoutBloc(
        gh<_i648.LoadCheckoutDraft>(),
        gh<_i1037.SaveCheckoutDraft>(),
        gh<_i1023.StartNewCheckout>(),
        gh<_i637.SubmitCheckout>(),
      ),
    );
    gh.lazySingleton<_i392.GetCheckoutCatalog>(
      () => _i392.GetCheckoutCatalog(gh<_i448.CatalogRepository>()),
    );
    gh.lazySingleton<_i260.AuthGuard>(
      () => _i260.AuthGuard(gh<_i56.GetCurrentSession>()),
    );
    gh.lazySingleton<_i989.AuthBloc>(
      () => _i989.AuthBloc(
        gh<_i56.GetCurrentSession>(),
        gh<_i887.SignIn>(),
        gh<_i66.SignOut>(),
      ),
    );
    gh.lazySingleton<_i800.CatalogBloc>(
      () => _i800.CatalogBloc(gh<_i392.GetCheckoutCatalog>()),
    );
    gh.lazySingleton<_i342.AppRouter>(
      () => _i342.AppRouter(gh<_i260.AuthGuard>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i317.RegisterModule {}
