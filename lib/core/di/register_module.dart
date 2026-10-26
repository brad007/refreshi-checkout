import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../graphql/local/local_backend_store.dart';
import '../graphql/local/local_checkout_backend.dart';
import '../graphql/local/local_graphql_link.dart';
import '../graphql/local/peach/peach_payments_simulator.dart';
import '../utils/id_generator.dart';

/// Third-party and infrastructure registrations that can't be annotated.
@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  Uuid get uuid => const Uuid();

  @lazySingleton
  LocalBackendStore backendStore(SharedPreferences prefs) => LocalBackendStore(prefs);

  @lazySingleton
  LocalCheckoutBackend backend(LocalBackendStore store, IdGenerator ids) => LocalCheckoutBackend(
    store,
    clock: DateTime.now,
    idGenerator: () => ids().replaceAll('-', '').substring(0, 12),
    // Peach payment ids are 32 hex characters.
    peach: PeachPaymentsSimulator(clock: DateTime.now, idGenerator: () => ids().replaceAll('-', '')),
  )..resumePendingHolds();

  /// The typed client is wired exactly as it would be for a real server; only
  /// the terminating link differs. Caching is off: every screen in this flow
  /// needs fresh server state, and there is no network cost to save.
  @lazySingleton
  GraphQLClient graphQLClient(LocalCheckoutBackend backend) => GraphQLClient(
    link: LocalGraphQLLink(backend.executor),
    cache: GraphQLCache(),
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.noCache),
      mutate: Policies(fetch: FetchPolicy.noCache),
      subscribe: Policies(fetch: FetchPolicy.noCache),
    ),
  );
}
