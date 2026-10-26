import 'package:flutter_test/flutter_test.dart';
import 'package:gql/language.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:refreshi_checkout/core/error/exceptions.dart';
import 'package:refreshi_checkout/core/graphql/local/local_graphql_executor.dart';

Request _request(String document, {Map<String, dynamic> variables = const {}, String? operationName}) => Request(
  operation: Operation(document: parseString(document), operationName: operationName),
  variables: variables,
);

void main() {
  final person = {
    '__typename': 'Person',
    'id': '1',
    'name': 'Ada',
    'createdAt': DateTime.utc(2030, 1, 1),
    'friends': [
      {'__typename': 'Person', 'id': '2', 'name': 'Grace'},
    ],
  };

  late Map<String, dynamic> lastArgs;
  late LocalGraphQLExecutor executor;

  setUp(() {
    lastArgs = {};
    executor = LocalGraphQLExecutor(
      query: {
        'person': (args) {
          lastArgs = args;
          return person;
        },
        'people': (_) => [person],
        'nothing': (_) => null,
        'broken': (_) => throw const LocalGraphQLError.notFound('Nope'),
        'scalarAsObject': (_) => 42,
      },
      mutation: {
        'rename': (args) => {...person, 'name': args['name']},
      },
      subscription: {
        'ticks': (args) => Stream.fromIterable([
          {'__typename': 'Tick', 'n': 1},
          {'__typename': 'Tick', 'n': 2},
        ]),
        'failing': (_) => Stream.error(const LocalGraphQLError('boom', code: 'X')),
        'crashing': (_) => Stream.error(StateError('unexpected')),
        // A narrower stream type, as real resolvers return.
        'typed': (_) => Stream<Map<String, dynamic>>.value({'__typename': 'Tick', 'n': 3}),
      },
    );
  });

  Future<Response> run(String doc, {Map<String, dynamic> variables = const {}, String? operationName}) =>
      executor.execute(_request(doc, variables: variables, operationName: operationName)).first;

  group('queries', () {
    test('projects only the selected fields', () async {
      final response = await run('{ person { id name } }');
      expect(response.data, {
        'person': {'id': '1', 'name': 'Ada'},
      });
      expect(response.errors, isNull);
    });

    test('resolves __typename at the root and on objects', () async {
      final response = await run('{ __typename person { __typename id } }');
      expect(response.data, {
        '__typename': 'Query',
        'person': {'__typename': 'Person', 'id': '1'},
      });
    });

    test('honours aliases', () async {
      final response = await run('{ who: person { label: name } }');
      expect(response.data, {
        'who': {'label': 'Ada'},
      });
    });

    test('serialises DateTime scalars as UTC ISO-8601', () async {
      final response = await run('{ person { createdAt } }');
      expect((response.data!['person'] as Map)['createdAt'], '2030-01-01T00:00:00.000Z');
    });

    test('projects lists of objects and nested lists', () async {
      final response = await run('{ people { name friends { name } } }');
      expect(response.data, {
        'people': [
          {
            'name': 'Ada',
            'friends': [
              {'name': 'Grace'},
            ],
          },
        ],
      });
    });

    test('returns null for null fields', () async {
      final response = await run('{ nothing { id } }');
      expect(response.data, {'nothing': null});
    });

    test('expands fragment spreads and merges overlapping selections', () async {
      final response = await run('''
        query Q { person { ...A ...B friends { id } } }
        fragment A on Person { id friends { name } }
        fragment B on Person { name }
      ''');
      expect(response.data, {
        'person': {
          'id': '1',
          'name': 'Ada',
          'friends': [
            {'name': 'Grace', 'id': '2'},
          ],
        },
      });
    });

    test('applies inline fragments only when the type matches', () async {
      final response = await run('{ person { id ... on Person { name } ... on Robot { model } ... { __typename } } }');
      expect(response.data, {
        'person': {'id': '1', 'name': 'Ada', '__typename': 'Person'},
      });
    });

    test('skips fragment spreads for other types', () async {
      final response = await run('''
        { person { id ...R } }
        fragment R on Robot { model }
      ''');
      expect(response.data, {
        'person': {'id': '1'},
      });
    });

    test('accepts root-level fragment spreads and inline fragments', () async {
      final response = await run('''
        query Q { ...Root ... { nothing { id } } }
        fragment Root on Query { person { id } }
      ''');
      expect(response.data, {
        'person': {'id': '1'},
        'nothing': null,
      });
    });

    test('resolves variables, defaults and every literal kind', () async {
      await run(
        r'''
        query Q($id: ID!, $limit: Int = 5) {
          person(id: $id, limit: $limit, i: 1, f: 1.5, s: "x", b: true, n: null, e: RED, l: [1, 2], o: {a: 1}) { id }
        }
        ''',
        variables: {'id': '1'},
      );
      expect(lastArgs, {
        'id': '1',
        'limit': 5,
        'i': 1,
        'f': 1.5,
        's': 'x',
        'b': true,
        'n': null,
        'e': 'RED',
        'l': [1, 2],
        'o': {'a': 1},
      });
    });

    test('turns resolver errors into GraphQL errors with a code', () async {
      final response = await run('{ broken { id } }');
      expect(response.data, isNull);
      expect(response.errors!.single.message, 'Nope');
      expect(response.errors!.single.extensions, {'code': ErrorCodes.notFound});
    });

    test('rejects unknown root fields', () async {
      final response = await run('{ unknown }');
      expect(response.errors!.single.extensions!['code'], ErrorCodes.badUserInput);
    });

    test('rejects unknown fragments', () async {
      final response = await run('{ person { ...Missing } }');
      expect(response.errors!.single.message, contains('Unknown fragment'));
    });

    test('rejects an object selection on a scalar', () async {
      final response = await run('{ scalarAsObject { id } }');
      expect(response.errors!.single.extensions!['code'], ErrorCodes.internal);
    });
  });

  group('operation selection', () {
    const doc = 'query A { person { id } } query B { person { name } }';

    test('runs the named operation', () async {
      final response = await run(doc, operationName: 'B');
      expect(response.data, {
        'person': {'name': 'Ada'},
      });
    });

    test('errors when the operation is ambiguous', () async {
      final response = await run(doc);
      expect(response.errors!.single.extensions!['code'], ErrorCodes.badUserInput);
    });

    test('falls back to the only operation when the name does not match', () async {
      final response = await run('query A { person { id } }', operationName: 'Other');
      expect(response.data, {
        'person': {'id': '1'},
      });
    });
  });

  test('mutations pass input arguments to resolvers', () async {
    final response = await run(
      r'mutation M($name: String!) { rename(name: $name) { name } }',
      variables: {'name': 'Bob'},
    );
    expect(response.data, {
      'rename': {'name': 'Bob'},
    });
  });

  group('subscriptions', () {
    test('emits one response per event', () async {
      final responses = await executor.execute(_request('subscription { ticks { n } }')).toList();
      expect(responses.map((r) => r.data), [
        {
          '__typename': 'Subscription',
          'ticks': {'n': 1},
        },
        {
          '__typename': 'Subscription',
          'ticks': {'n': 2},
        },
      ]);
    });

    test('accepts resolvers that return a narrower stream type', () async {
      final responses = await executor.execute(_request('subscription { typed { n } }')).toList();
      expect((responses.single.data!['typed'] as Map)['n'], 3);
    });

    test('turns stream errors into GraphQL error responses', () async {
      final responses = await executor.execute(_request('subscription { failing { n } }')).toList();
      expect(responses.single.errors!.single.extensions, {'code': 'X'});
    });

    test('wraps unexpected stream errors as internal errors', () async {
      final responses = await executor.execute(_request('subscription { crashing { n } }')).toList();
      expect(responses.single.errors!.single.extensions!['code'], ErrorCodes.internal);
    });

    test('requires exactly one root field', () async {
      final responses = await executor.execute(_request('subscription { ticks { n } failing { n } }')).toList();
      expect(responses.single.errors!.single.extensions!['code'], ErrorCodes.badUserInput);
    });

    test('rejects unknown subscription fields', () async {
      final responses = await executor.execute(_request('subscription { nope { n } }')).toList();
      expect(responses.single.errors!.single.message, contains('Subscription.nope'));
    });
  });

  test('errors describe themselves', () {
    expect(const LocalGraphQLError.notFound('Gone').toString(), 'LocalGraphQLError(NOT_FOUND: Gone)');
  });
}
