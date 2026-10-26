import 'dart:async';

import 'package:gql/ast.dart';
import 'package:gql_exec/gql_exec.dart';

import '../../error/exceptions.dart';

typedef FieldResolver = FutureOr<Object?> Function(Map<String, dynamic> args);
typedef SubscriptionResolver = Stream<Object?> Function(Map<String, dynamic> args);

/// An error raised by a resolver; surfaced as a GraphQL error with
/// `extensions.code`, the same shape a real server would return.
class LocalGraphQLError implements Exception {
  const LocalGraphQLError(this.message, {this.code = ErrorCodes.internal, this.extensions = const {}});

  const LocalGraphQLError.notFound([String message = 'Not found']) : this(message, code: ErrorCodes.notFound);

  const LocalGraphQLError.badInput(String message) : this(message, code: ErrorCodes.badUserInput);

  final String message;
  final String code;
  final Map<String, dynamic> extensions;

  GraphQLError toGraphQLError() => GraphQLError(message: message, extensions: {'code': code, ...extensions});

  @override
  String toString() => 'LocalGraphQLError($code: $message)';
}

/// A deliberately small GraphQL executor for the in-app backend.
///
/// Root fields are resolved by plain Dart functions that return JSON-like
/// objects (each object carries its `__typename`). The executor then projects
/// those objects onto the client's selection set, honouring aliases, fragment
/// spreads and inline fragments, so responses have exactly the shape the
/// generated client types expect.
///
/// Not supported (not needed by this schema): arguments on nested fields,
/// directives, and validating documents against the schema at runtime —
/// documents are already validated at build time by graphql_codegen.
class LocalGraphQLExecutor {
  LocalGraphQLExecutor({this.query = const {}, this.mutation = const {}, this.subscription = const {}});

  final Map<String, FieldResolver> query;
  final Map<String, FieldResolver> mutation;
  final Map<String, SubscriptionResolver> subscription;

  Stream<Response> execute(Request request) {
    final document = request.operation.document;
    final OperationDefinitionNode operation;
    try {
      operation = _selectOperation(document, request.operation.operationName);
    } on LocalGraphQLError catch (e) {
      return Stream.value(_errorResponse(e));
    }

    final fragments = {for (final def in document.definitions.whereType<FragmentDefinitionNode>()) def.name.value: def};
    final variables = {..._defaultVariables(operation), ...request.variables};
    final context = _ExecutionContext(fragments, variables);

    return switch (operation.type) {
      OperationType.query => Stream.fromFuture(_executeFields(operation, query, 'Query', context)),
      OperationType.mutation => Stream.fromFuture(_executeFields(operation, mutation, 'Mutation', context)),
      OperationType.subscription => _executeSubscription(operation, context),
    };
  }

  OperationDefinitionNode _selectOperation(DocumentNode document, String? name) {
    final operations = document.definitions.whereType<OperationDefinitionNode>().toList();
    if (name != null) {
      final match = operations.where((op) => op.name?.value == name);
      if (match.isNotEmpty) return match.first;
    }
    if (operations.length == 1) return operations.single;
    throw const LocalGraphQLError.badInput('Could not determine which operation to run');
  }

  Map<String, dynamic> _defaultVariables(OperationDefinitionNode operation) => {
    for (final def in operation.variableDefinitions)
      if (def.defaultValue?.value case final value?) def.variable.name.value: _valueFromAst(value, const {}),
  };

  Future<Response> _executeFields(
    OperationDefinitionNode operation,
    Map<String, FieldResolver> resolvers,
    String typename,
    _ExecutionContext context,
  ) async {
    final data = <String, dynamic>{};
    try {
      // Root fields run serially, which is what the spec requires for mutations.
      for (final field in _rootFields(operation, context)) {
        final key = field.alias?.value ?? field.name.value;
        if (field.name.value == '__typename') {
          data[key] = typename;
          continue;
        }
        final resolver = resolvers[field.name.value];
        if (resolver == null) {
          throw LocalGraphQLError.badInput('Unknown field "$typename.${field.name.value}"');
        }
        final value = await resolver(_arguments(field, context));
        data[key] = _complete(value, field.selectionSet, context);
      }
    } on LocalGraphQLError catch (e) {
      return _errorResponse(e);
    }
    return Response(data: data, response: {'data': data});
  }

  Stream<Response> _executeSubscription(OperationDefinitionNode operation, _ExecutionContext context) {
    final fields = _rootFields(operation, context).where((f) => f.name.value != '__typename').toList();
    if (fields.length != 1) {
      return Stream.value(
        _errorResponse(const LocalGraphQLError.badInput('A subscription must select exactly one root field')),
      );
    }
    final field = fields.single;
    final resolver = subscription[field.name.value];
    if (resolver == null) {
      return Stream.value(
        _errorResponse(LocalGraphQLError.badInput('Unknown field "Subscription.${field.name.value}"')),
      );
    }
    final key = field.alias?.value ?? field.name.value;
    // `cast` because resolvers return narrower streams (e.g. Stream<Map>),
    // which a StreamTransformer<Object?, …> can't accept under covariance.
    return resolver(_arguments(field, context)).cast<Object?>().transform(
      StreamTransformer<Object?, Response>.fromHandlers(
        handleData: (value, sink) {
          final data = {'__typename': 'Subscription', key: _complete(value, field.selectionSet, context)};
          sink.add(Response(data: data, response: {'data': data}));
        },
        handleError: (error, stackTrace, sink) {
          final e = error is LocalGraphQLError ? error : LocalGraphQLError(error.toString());
          sink.add(_errorResponse(e));
        },
      ),
    );
  }

  Iterable<FieldNode> _rootFields(OperationDefinitionNode operation, _ExecutionContext context) sync* {
    for (final selection in operation.selectionSet.selections) {
      switch (selection) {
        case FieldNode():
          yield selection;
        case FragmentSpreadNode():
          final fragment = context.fragments[selection.name.value];
          if (fragment != null) yield* fragment.selectionSet.selections.whereType<FieldNode>();
        case InlineFragmentNode():
          yield* selection.selectionSet.selections.whereType<FieldNode>();
      }
    }
  }

  Map<String, dynamic> _arguments(FieldNode field, _ExecutionContext context) => {
    for (final arg in field.arguments) arg.name.value: _valueFromAst(arg.value, context.variables),
  };

  Object? _valueFromAst(ValueNode node, Map<String, dynamic> variables) => switch (node) {
    VariableNode(:final name) => variables[name.value],
    IntValueNode(:final value) => int.parse(value),
    FloatValueNode(:final value) => double.parse(value),
    StringValueNode(:final value) => value,
    BooleanValueNode(:final value) => value,
    NullValueNode() => null,
    EnumValueNode(:final name) => name.value,
    ListValueNode(:final values) => [for (final v in values) _valueFromAst(v, variables)],
    ObjectValueNode(:final fields) => {for (final f in fields) f.name.value: _valueFromAst(f.value, variables)},
    _ => throw LocalGraphQLError.badInput('Unsupported value ${node.runtimeType}'),
  };

  Object? _complete(Object? value, SelectionSetNode? selectionSet, _ExecutionContext context) {
    if (value == null) return null;
    if (value is List) return [for (final item in value) _complete(item, selectionSet, context)];
    if (selectionSet == null) return value is DateTime ? value.toUtc().toIso8601String() : value;
    if (value is! Map) {
      throw LocalGraphQLError('Expected an object but resolved ${value.runtimeType}');
    }
    final out = <String, dynamic>{};
    _collect(value.cast<String, Object?>(), selectionSet, out, context);
    return out;
  }

  void _collect(
    Map<String, Object?> object,
    SelectionSetNode selectionSet,
    Map<String, dynamic> out,
    _ExecutionContext context,
  ) {
    for (final selection in selectionSet.selections) {
      switch (selection) {
        case FieldNode():
          final key = selection.alias?.value ?? selection.name.value;
          final value = selection.name.value == '__typename'
              ? object['__typename']
              : _complete(object[selection.name.value], selection.selectionSet, context);
          out[key] = _merge(out[key], value);
        case InlineFragmentNode():
          if (_typeMatches(selection.typeCondition?.on.name.value, object)) {
            _collect(object, selection.selectionSet, out, context);
          }
        case FragmentSpreadNode():
          final fragment = context.fragments[selection.name.value];
          if (fragment == null) {
            throw LocalGraphQLError.badInput('Unknown fragment "${selection.name.value}"');
          }
          if (_typeMatches(fragment.typeCondition.on.name.value, object)) {
            _collect(object, fragment.selectionSet, out, context);
          }
      }
    }
  }

  bool _typeMatches(String? typeCondition, Map<String, Object?> object) =>
      typeCondition == null || typeCondition == object['__typename'];

  /// The same field can be selected by several fragments with different
  /// sub-selections; their results are merged rather than overwritten.
  Object? _merge(Object? existing, Object? next) {
    if (existing is Map<String, dynamic> && next is Map<String, dynamic>) {
      return {...existing, for (final entry in next.entries) entry.key: _merge(existing[entry.key], entry.value)};
    }
    if (existing is List && next is List && existing.length == next.length) {
      return [for (var i = 0; i < next.length; i++) _merge(existing[i], next[i])];
    }
    return next;
  }

  Response _errorResponse(LocalGraphQLError error) {
    final graphQLError = error.toGraphQLError();
    return Response(
      errors: [graphQLError],
      response: {
        'errors': [
          {'message': graphQLError.message, 'extensions': graphQLError.extensions},
        ],
      },
    );
  }
}

class _ExecutionContext {
  const _ExecutionContext(this.fragments, this.variables);

  final Map<String, FragmentDefinitionNode> fragments;
  final Map<String, dynamic> variables;
}
