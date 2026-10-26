import 'package:graphql/client.dart';
import 'package:refreshi_checkout/core/graphql/local/local_backend_store.dart';
import 'package:refreshi_checkout/core/graphql/local/local_checkout_backend.dart';
import 'package:refreshi_checkout/core/graphql/local/local_graphql_link.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A real typed client talking to the real in-app backend, with no latency.
/// Data-source tests use this instead of mocks: it exercises generated
/// documents, the executor and the parsers end to end.
class LocalApi {
  LocalApi._(this.client, this.backend);

  static Future<LocalApi> create({Duration holdConfirmationDelay = const Duration(milliseconds: 30)}) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    var ids = 0;
    final backend = LocalCheckoutBackend(
      LocalBackendStore(prefs),
      clock: DateTime.now,
      idGenerator: () => 'test${++ids}',
      config: LocalBackendConfig(latency: Duration.zero, holdConfirmationDelay: holdConfirmationDelay),
    );
    final client = GraphQLClient(
      link: LocalGraphQLLink(backend.executor),
      cache: GraphQLCache(),
      defaultPolicies: DefaultPolicies(
        query: Policies(fetch: FetchPolicy.noCache),
        mutate: Policies(fetch: FetchPolicy.noCache),
        subscribe: Policies(fetch: FetchPolicy.noCache),
      ),
    );
    return LocalApi._(client, backend);
  }

  final GraphQLClient client;
  final LocalCheckoutBackend backend;

  /// A slot id that's always bookable: tomorrow at 12:00.
  String get tomorrowSlotId {
    final now = DateTime.now();
    return 'slot_${DateTime(now.year, now.month, now.day + 1, 12).millisecondsSinceEpoch}';
  }

  void dispose() => backend.dispose();
}
