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
import 'package:refreshi_checkout/core/di/register_module.dart' as _i268;
import 'package:refreshi_checkout/core/graphql/local/local_backend_store.dart'
    as _i1038;
import 'package:refreshi_checkout/core/graphql/local/local_checkout_backend.dart'
    as _i628;
import 'package:refreshi_checkout/core/router/app_router.dart' as _i581;
import 'package:refreshi_checkout/core/router/auth_guard.dart' as _i1057;
import 'package:refreshi_checkout/core/utils/id_generator.dart' as _i386;
import 'package:refreshi_checkout/features/auth/data/datasources/auth_local_data_source.dart'
    as _i339;
import 'package:refreshi_checkout/features/auth/data/repositories/auth_repository_impl.dart'
    as _i447;
import 'package:refreshi_checkout/features/auth/domain/repositories/auth_repository.dart'
    as _i222;
import 'package:refreshi_checkout/features/auth/domain/usecases/get_current_session.dart'
    as _i984;
import 'package:refreshi_checkout/features/auth/domain/usecases/sign_in.dart'
    as _i600;
import 'package:refreshi_checkout/features/auth/domain/usecases/sign_out.dart'
    as _i153;
import 'package:refreshi_checkout/features/auth/presentation/bloc/auth_bloc.dart'
    as _i407;
import 'package:refreshi_checkout/features/catalog/data/datasources/catalog_remote_data_source.dart'
    as _i916;
import 'package:refreshi_checkout/features/catalog/data/repositories/catalog_repository_impl.dart'
    as _i725;
import 'package:refreshi_checkout/features/catalog/domain/repositories/catalog_repository.dart'
    as _i304;
import 'package:refreshi_checkout/features/catalog/domain/usecases/get_checkout_catalog.dart'
    as _i464;
import 'package:refreshi_checkout/features/catalog/presentation/bloc/catalog_bloc.dart'
    as _i665;
import 'package:refreshi_checkout/features/checkout/data/datasources/checkout_local_data_source.dart'
    as _i539;
import 'package:refreshi_checkout/features/checkout/data/repositories/checkout_repository_impl.dart'
    as _i1067;
import 'package:refreshi_checkout/features/checkout/domain/repositories/checkout_repository.dart'
    as _i904;
import 'package:refreshi_checkout/features/checkout/domain/usecases/load_checkout_draft.dart'
    as _i652;
import 'package:refreshi_checkout/features/checkout/domain/usecases/save_checkout_draft.dart'
    as _i181;
import 'package:refreshi_checkout/features/checkout/domain/usecases/start_new_checkout.dart'
    as _i1022;
import 'package:refreshi_checkout/features/checkout/domain/usecases/submit_checkout.dart'
    as _i126;
import 'package:refreshi_checkout/features/checkout/presentation/bloc/checkout_bloc.dart'
    as _i785;
import 'package:refreshi_checkout/features/orders/data/datasources/order_remote_data_source.dart'
    as _i274;
import 'package:refreshi_checkout/features/orders/data/repositories/order_repository_impl.dart'
    as _i921;
import 'package:refreshi_checkout/features/orders/domain/repositories/order_repository.dart'
    as _i390;
import 'package:refreshi_checkout/features/orders/domain/usecases/create_order.dart'
    as _i986;
import 'package:refreshi_checkout/features/orders/domain/usecases/get_order.dart'
    as _i442;
import 'package:refreshi_checkout/features/orders/domain/usecases/watch_order.dart'
    as _i1013;
import 'package:refreshi_checkout/features/orders/presentation/bloc/order_details_bloc.dart'
    as _i961;
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
    gh.lazySingleton<_i386.IdGenerator>(
      () => _i386.IdGenerator(gh<_i706.Uuid>()),
    );
    gh.lazySingleton<_i339.AuthLocalDataSource>(
      () => _i339.AuthLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i539.CheckoutLocalDataSource>(
      () => _i539.CheckoutLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i904.CheckoutRepository>(
      () => _i1067.CheckoutRepositoryImpl(
        gh<_i539.CheckoutLocalDataSource>(),
        gh<_i386.IdGenerator>(),
      ),
    );
    gh.lazySingleton<_i1038.LocalBackendStore>(
      () => registerModule.backendStore(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i652.LoadCheckoutDraft>(
      () => _i652.LoadCheckoutDraft(gh<_i904.CheckoutRepository>()),
    );
    gh.lazySingleton<_i181.SaveCheckoutDraft>(
      () => _i181.SaveCheckoutDraft(gh<_i904.CheckoutRepository>()),
    );
    gh.lazySingleton<_i1022.StartNewCheckout>(
      () => _i1022.StartNewCheckout(gh<_i904.CheckoutRepository>()),
    );
    gh.lazySingleton<_i222.AuthRepository>(
      () => _i447.AuthRepositoryImpl(gh<_i339.AuthLocalDataSource>()),
    );
    gh.lazySingleton<_i628.LocalCheckoutBackend>(
      () => registerModule.backend(
        gh<_i1038.LocalBackendStore>(),
        gh<_i386.IdGenerator>(),
      ),
    );
    gh.lazySingleton<_i763.GraphQLClient>(
      () => registerModule.graphQLClient(gh<_i628.LocalCheckoutBackend>()),
    );
    gh.lazySingleton<_i274.OrderRemoteDataSource>(
      () => _i274.OrderRemoteDataSourceImpl(gh<_i763.GraphQLClient>()),
    );
    gh.lazySingleton<_i984.GetCurrentSession>(
      () => _i984.GetCurrentSession(gh<_i222.AuthRepository>()),
    );
    gh.lazySingleton<_i600.SignIn>(
      () => _i600.SignIn(gh<_i222.AuthRepository>()),
    );
    gh.lazySingleton<_i153.SignOut>(
      () => _i153.SignOut(gh<_i222.AuthRepository>()),
    );
    gh.lazySingleton<_i407.AuthBloc>(
      () => _i407.AuthBloc(
        gh<_i984.GetCurrentSession>(),
        gh<_i600.SignIn>(),
        gh<_i153.SignOut>(),
      ),
    );
    gh.lazySingleton<_i390.OrderRepository>(
      () => _i921.OrderRepositoryImpl(gh<_i274.OrderRemoteDataSource>()),
    );
    gh.lazySingleton<_i916.CatalogRemoteDataSource>(
      () => _i916.CatalogRemoteDataSourceImpl(gh<_i763.GraphQLClient>()),
    );
    gh.lazySingleton<_i1057.AuthGuard>(
      () => _i1057.AuthGuard(gh<_i984.GetCurrentSession>()),
    );
    gh.lazySingleton<_i304.CatalogRepository>(
      () => _i725.CatalogRepositoryImpl(gh<_i916.CatalogRemoteDataSource>()),
    );
    gh.lazySingleton<_i986.CreateOrder>(
      () => _i986.CreateOrder(gh<_i390.OrderRepository>()),
    );
    gh.lazySingleton<_i442.GetOrder>(
      () => _i442.GetOrder(gh<_i390.OrderRepository>()),
    );
    gh.lazySingleton<_i1013.WatchOrder>(
      () => _i1013.WatchOrder(gh<_i390.OrderRepository>()),
    );
    gh.factory<_i961.OrderDetailsBloc>(
      () =>
          _i961.OrderDetailsBloc(gh<_i442.GetOrder>(), gh<_i1013.WatchOrder>()),
    );
    gh.lazySingleton<_i581.AppRouter>(
      () => _i581.AppRouter(gh<_i1057.AuthGuard>()),
    );
    gh.lazySingleton<_i464.GetCheckoutCatalog>(
      () => _i464.GetCheckoutCatalog(gh<_i304.CatalogRepository>()),
    );
    gh.lazySingleton<_i126.SubmitCheckout>(
      () => _i126.SubmitCheckout(
        gh<_i904.CheckoutRepository>(),
        gh<_i986.CreateOrder>(),
      ),
    );
    gh.lazySingleton<_i785.CheckoutBloc>(
      () => _i785.CheckoutBloc(
        gh<_i652.LoadCheckoutDraft>(),
        gh<_i181.SaveCheckoutDraft>(),
        gh<_i1022.StartNewCheckout>(),
        gh<_i126.SubmitCheckout>(),
      ),
    );
    gh.lazySingleton<_i665.CatalogBloc>(
      () => _i665.CatalogBloc(gh<_i464.GetCheckoutCatalog>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i268.RegisterModule {}
