import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:refreshi_checkout/injection.dart';
import 'package:refreshi_checkout/infrastructure/core/graphql/local/local_checkout_backend.dart';
import 'package:refreshi_checkout/presentation/core/router/app_router.dart';
import 'package:refreshi_checkout/infrastructure/core/id_generator.dart';
import 'package:refreshi_checkout/application/auth/auth_bloc.dart';
import 'package:refreshi_checkout/application/catalog/catalog_bloc.dart';
import 'package:refreshi_checkout/application/checkout/checkout_bloc.dart';
import 'package:refreshi_checkout/application/orders/order_details_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await getIt.reset();
  });

  tearDown(() async {
    if (getIt.isRegistered<LocalCheckoutBackend>()) getIt<LocalCheckoutBackend>().dispose();
    await getIt.reset();
  });

  test('the whole graph resolves', () async {
    await configureDependencies();

    expect(getIt<AppRouter>(), isA<AppRouter>());
    expect(getIt<GraphQLClient>(), isA<GraphQLClient>());
    expect(getIt<AuthBloc>(), same(getIt<AuthBloc>()), reason: 'app-wide blocs are singletons');
    expect(getIt<CatalogBloc>(), same(getIt<CatalogBloc>()));
    expect(getIt<CheckoutBloc>(), same(getIt<CheckoutBloc>()));
    expect(getIt<OrderDetailsBloc>(), isNot(same(getIt<OrderDetailsBloc>())), reason: 'one per page');
  });

  test('ids are unique and order ids are short', () async {
    await configureDependencies();
    final ids = getIt<IdGenerator>();
    expect(ids(), isNot(ids()));
    expect(getIt<LocalCheckoutBackend>().idGenerator(), hasLength(12));
  });
}
