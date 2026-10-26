import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$ServiceFields {
  Fragment$ServiceFields({
    required this.id,
    required this.name,
    required this.storeName,
    required this.category,
    required this.description,
    required this.priceCents,
    required this.originalPriceCents,
    this.$__typename = 'Service',
  });

  factory Fragment$ServiceFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$storeName = json['storeName'];
    final l$category = json['category'];
    final l$description = json['description'];
    final l$priceCents = json['priceCents'];
    final l$originalPriceCents = json['originalPriceCents'];
    final l$$__typename = json['__typename'];
    return Fragment$ServiceFields(
      id: (l$id as String),
      name: (l$name as String),
      storeName: (l$storeName as String),
      category: (l$category as String),
      description: (l$description as String),
      priceCents: (l$priceCents as int),
      originalPriceCents: (l$originalPriceCents as int),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String storeName;

  final String category;

  final String description;

  final int priceCents;

  final int originalPriceCents;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$storeName = storeName;
    _resultData['storeName'] = l$storeName;
    final l$category = category;
    _resultData['category'] = l$category;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$priceCents = priceCents;
    _resultData['priceCents'] = l$priceCents;
    final l$originalPriceCents = originalPriceCents;
    _resultData['originalPriceCents'] = l$originalPriceCents;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$storeName = storeName;
    final l$category = category;
    final l$description = description;
    final l$priceCents = priceCents;
    final l$originalPriceCents = originalPriceCents;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$storeName,
      l$category,
      l$description,
      l$priceCents,
      l$originalPriceCents,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$ServiceFields || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$storeName = storeName;
    final lOther$storeName = other.storeName;
    if (l$storeName != lOther$storeName) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$priceCents = priceCents;
    final lOther$priceCents = other.priceCents;
    if (l$priceCents != lOther$priceCents) {
      return false;
    }
    final l$originalPriceCents = originalPriceCents;
    final lOther$originalPriceCents = other.originalPriceCents;
    if (l$originalPriceCents != lOther$originalPriceCents) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$ServiceFields on Fragment$ServiceFields {
  CopyWith$Fragment$ServiceFields<Fragment$ServiceFields> get copyWith =>
      CopyWith$Fragment$ServiceFields(this, (i) => i);
}

abstract class CopyWith$Fragment$ServiceFields<TRes> {
  factory CopyWith$Fragment$ServiceFields(Fragment$ServiceFields instance, TRes Function(Fragment$ServiceFields) then) =
      _CopyWithImpl$Fragment$ServiceFields;

  factory CopyWith$Fragment$ServiceFields.stub(TRes res) = _CopyWithStubImpl$Fragment$ServiceFields;

  TRes call({
    String? id,
    String? name,
    String? storeName,
    String? category,
    String? description,
    int? priceCents,
    int? originalPriceCents,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$ServiceFields<TRes> implements CopyWith$Fragment$ServiceFields<TRes> {
  _CopyWithImpl$Fragment$ServiceFields(this._instance, this._then);

  final Fragment$ServiceFields _instance;

  final TRes Function(Fragment$ServiceFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? storeName = _undefined,
    Object? category = _undefined,
    Object? description = _undefined,
    Object? priceCents = _undefined,
    Object? originalPriceCents = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$ServiceFields(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      name: name == _undefined || name == null ? _instance.name : (name as String),
      storeName: storeName == _undefined || storeName == null ? _instance.storeName : (storeName as String),
      category: category == _undefined || category == null ? _instance.category : (category as String),
      description: description == _undefined || description == null ? _instance.description : (description as String),
      priceCents: priceCents == _undefined || priceCents == null ? _instance.priceCents : (priceCents as int),
      originalPriceCents: originalPriceCents == _undefined || originalPriceCents == null
          ? _instance.originalPriceCents
          : (originalPriceCents as int),
      $__typename: $__typename == _undefined || $__typename == null ? _instance.$__typename : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$ServiceFields<TRes> implements CopyWith$Fragment$ServiceFields<TRes> {
  _CopyWithStubImpl$Fragment$ServiceFields(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? storeName,
    String? category,
    String? description,
    int? priceCents,
    int? originalPriceCents,
    String? $__typename,
  }) => _res;
}

const fragmentDefinitionServiceFields = FragmentDefinitionNode(
  name: NameNode(value: 'ServiceFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Service'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'id'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'name'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'storeName'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'category'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'description'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'priceCents'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'originalPriceCents'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentServiceFields = DocumentNode(definitions: [fragmentDefinitionServiceFields]);

extension ClientExtension$Fragment$ServiceFields on graphql.GraphQLClient {
  void writeFragment$ServiceFields({
    required Fragment$ServiceFields data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(fragmentName: 'ServiceFields', document: documentNodeFragmentServiceFields),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$ServiceFields? readFragment$ServiceFields({required Map<String, dynamic> idFields, bool optimistic = true}) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(fragmentName: 'ServiceFields', document: documentNodeFragmentServiceFields),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$ServiceFields.fromJson(result);
  }
}

class Fragment$TimeSlotFields {
  Fragment$TimeSlotFields({
    required this.id,
    required this.startsAt,
    required this.endsAt,
    this.$__typename = 'TimeSlot',
  });

  factory Fragment$TimeSlotFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$startsAt = json['startsAt'];
    final l$endsAt = json['endsAt'];
    final l$$__typename = json['__typename'];
    return Fragment$TimeSlotFields(
      id: (l$id as String),
      startsAt: DateTime.parse((l$startsAt as String)),
      endsAt: DateTime.parse((l$endsAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final DateTime startsAt;

  final DateTime endsAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$startsAt = startsAt;
    _resultData['startsAt'] = l$startsAt.toIso8601String();
    final l$endsAt = endsAt;
    _resultData['endsAt'] = l$endsAt.toIso8601String();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$startsAt = startsAt;
    final l$endsAt = endsAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$startsAt, l$endsAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$TimeSlotFields || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$startsAt = startsAt;
    final lOther$startsAt = other.startsAt;
    if (l$startsAt != lOther$startsAt) {
      return false;
    }
    final l$endsAt = endsAt;
    final lOther$endsAt = other.endsAt;
    if (l$endsAt != lOther$endsAt) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$TimeSlotFields on Fragment$TimeSlotFields {
  CopyWith$Fragment$TimeSlotFields<Fragment$TimeSlotFields> get copyWith =>
      CopyWith$Fragment$TimeSlotFields(this, (i) => i);
}

abstract class CopyWith$Fragment$TimeSlotFields<TRes> {
  factory CopyWith$Fragment$TimeSlotFields(
    Fragment$TimeSlotFields instance,
    TRes Function(Fragment$TimeSlotFields) then,
  ) = _CopyWithImpl$Fragment$TimeSlotFields;

  factory CopyWith$Fragment$TimeSlotFields.stub(TRes res) = _CopyWithStubImpl$Fragment$TimeSlotFields;

  TRes call({String? id, DateTime? startsAt, DateTime? endsAt, String? $__typename});
}

class _CopyWithImpl$Fragment$TimeSlotFields<TRes> implements CopyWith$Fragment$TimeSlotFields<TRes> {
  _CopyWithImpl$Fragment$TimeSlotFields(this._instance, this._then);

  final Fragment$TimeSlotFields _instance;

  final TRes Function(Fragment$TimeSlotFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? startsAt = _undefined,
    Object? endsAt = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$TimeSlotFields(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      startsAt: startsAt == _undefined || startsAt == null ? _instance.startsAt : (startsAt as DateTime),
      endsAt: endsAt == _undefined || endsAt == null ? _instance.endsAt : (endsAt as DateTime),
      $__typename: $__typename == _undefined || $__typename == null ? _instance.$__typename : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$TimeSlotFields<TRes> implements CopyWith$Fragment$TimeSlotFields<TRes> {
  _CopyWithStubImpl$Fragment$TimeSlotFields(this._res);

  TRes _res;

  call({String? id, DateTime? startsAt, DateTime? endsAt, String? $__typename}) => _res;
}

const fragmentDefinitionTimeSlotFields = FragmentDefinitionNode(
  name: NameNode(value: 'TimeSlotFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'TimeSlot'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'id'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'startsAt'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'endsAt'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentTimeSlotFields = DocumentNode(definitions: [fragmentDefinitionTimeSlotFields]);

extension ClientExtension$Fragment$TimeSlotFields on graphql.GraphQLClient {
  void writeFragment$TimeSlotFields({
    required Fragment$TimeSlotFields data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(fragmentName: 'TimeSlotFields', document: documentNodeFragmentTimeSlotFields),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$TimeSlotFields? readFragment$TimeSlotFields({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(fragmentName: 'TimeSlotFields', document: documentNodeFragmentTimeSlotFields),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$TimeSlotFields.fromJson(result);
  }
}

class Fragment$PaymentMethodFields {
  Fragment$PaymentMethodFields({
    required this.id,
    required this.brand,
    required this.last4,
    this.$__typename = 'PaymentMethod',
  });

  factory Fragment$PaymentMethodFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$brand = json['brand'];
    final l$last4 = json['last4'];
    final l$$__typename = json['__typename'];
    return Fragment$PaymentMethodFields(
      id: (l$id as String),
      brand: (l$brand as String),
      last4: (l$last4 as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String brand;

  final String last4;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$brand = brand;
    _resultData['brand'] = l$brand;
    final l$last4 = last4;
    _resultData['last4'] = l$last4;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$brand = brand;
    final l$last4 = last4;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$brand, l$last4, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$PaymentMethodFields || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$brand = brand;
    final lOther$brand = other.brand;
    if (l$brand != lOther$brand) {
      return false;
    }
    final l$last4 = last4;
    final lOther$last4 = other.last4;
    if (l$last4 != lOther$last4) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$PaymentMethodFields on Fragment$PaymentMethodFields {
  CopyWith$Fragment$PaymentMethodFields<Fragment$PaymentMethodFields> get copyWith =>
      CopyWith$Fragment$PaymentMethodFields(this, (i) => i);
}

abstract class CopyWith$Fragment$PaymentMethodFields<TRes> {
  factory CopyWith$Fragment$PaymentMethodFields(
    Fragment$PaymentMethodFields instance,
    TRes Function(Fragment$PaymentMethodFields) then,
  ) = _CopyWithImpl$Fragment$PaymentMethodFields;

  factory CopyWith$Fragment$PaymentMethodFields.stub(TRes res) = _CopyWithStubImpl$Fragment$PaymentMethodFields;

  TRes call({String? id, String? brand, String? last4, String? $__typename});
}

class _CopyWithImpl$Fragment$PaymentMethodFields<TRes> implements CopyWith$Fragment$PaymentMethodFields<TRes> {
  _CopyWithImpl$Fragment$PaymentMethodFields(this._instance, this._then);

  final Fragment$PaymentMethodFields _instance;

  final TRes Function(Fragment$PaymentMethodFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? brand = _undefined,
    Object? last4 = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$PaymentMethodFields(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      brand: brand == _undefined || brand == null ? _instance.brand : (brand as String),
      last4: last4 == _undefined || last4 == null ? _instance.last4 : (last4 as String),
      $__typename: $__typename == _undefined || $__typename == null ? _instance.$__typename : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$PaymentMethodFields<TRes> implements CopyWith$Fragment$PaymentMethodFields<TRes> {
  _CopyWithStubImpl$Fragment$PaymentMethodFields(this._res);

  TRes _res;

  call({String? id, String? brand, String? last4, String? $__typename}) => _res;
}

const fragmentDefinitionPaymentMethodFields = FragmentDefinitionNode(
  name: NameNode(value: 'PaymentMethodFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'PaymentMethod'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'id'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'brand'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'last4'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentPaymentMethodFields = DocumentNode(definitions: [fragmentDefinitionPaymentMethodFields]);

extension ClientExtension$Fragment$PaymentMethodFields on graphql.GraphQLClient {
  void writeFragment$PaymentMethodFields({
    required Fragment$PaymentMethodFields data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'PaymentMethodFields',
        document: documentNodeFragmentPaymentMethodFields,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$PaymentMethodFields? readFragment$PaymentMethodFields({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'PaymentMethodFields',
          document: documentNodeFragmentPaymentMethodFields,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$PaymentMethodFields.fromJson(result);
  }
}

class Variables$Query$CheckoutCatalog {
  factory Variables$Query$CheckoutCatalog({required int days}) => Variables$Query$CheckoutCatalog._({r'days': days});

  Variables$Query$CheckoutCatalog._(this._$data);

  factory Variables$Query$CheckoutCatalog.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$days = data['days'];
    result$data['days'] = (l$days as int);
    return Variables$Query$CheckoutCatalog._(result$data);
  }

  Map<String, dynamic> _$data;

  int get days => (_$data['days'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$days = days;
    result$data['days'] = l$days;
    return result$data;
  }

  CopyWith$Variables$Query$CheckoutCatalog<Variables$Query$CheckoutCatalog> get copyWith =>
      CopyWith$Variables$Query$CheckoutCatalog(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$CheckoutCatalog || runtimeType != other.runtimeType) {
      return false;
    }
    final l$days = days;
    final lOther$days = other.days;
    if (l$days != lOther$days) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$days = days;
    return Object.hashAll([l$days]);
  }
}

abstract class CopyWith$Variables$Query$CheckoutCatalog<TRes> {
  factory CopyWith$Variables$Query$CheckoutCatalog(
    Variables$Query$CheckoutCatalog instance,
    TRes Function(Variables$Query$CheckoutCatalog) then,
  ) = _CopyWithImpl$Variables$Query$CheckoutCatalog;

  factory CopyWith$Variables$Query$CheckoutCatalog.stub(TRes res) = _CopyWithStubImpl$Variables$Query$CheckoutCatalog;

  TRes call({int? days});
}

class _CopyWithImpl$Variables$Query$CheckoutCatalog<TRes> implements CopyWith$Variables$Query$CheckoutCatalog<TRes> {
  _CopyWithImpl$Variables$Query$CheckoutCatalog(this._instance, this._then);

  final Variables$Query$CheckoutCatalog _instance;

  final TRes Function(Variables$Query$CheckoutCatalog) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? days = _undefined}) => _then(
    Variables$Query$CheckoutCatalog._({
      ..._instance._$data,
      if (days != _undefined && days != null) 'days': (days as int),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$CheckoutCatalog<TRes>
    implements CopyWith$Variables$Query$CheckoutCatalog<TRes> {
  _CopyWithStubImpl$Variables$Query$CheckoutCatalog(this._res);

  TRes _res;

  call({int? days}) => _res;
}

class Query$CheckoutCatalog {
  Query$CheckoutCatalog({
    required this.services,
    required this.availableSlots,
    required this.paymentMethods,
    this.$__typename = 'Query',
  });

  factory Query$CheckoutCatalog.fromJson(Map<String, dynamic> json) {
    final l$services = json['services'];
    final l$availableSlots = json['availableSlots'];
    final l$paymentMethods = json['paymentMethods'];
    final l$$__typename = json['__typename'];
    return Query$CheckoutCatalog(
      services: (l$services as List<dynamic>)
          .map((e) => Fragment$ServiceFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      availableSlots: (l$availableSlots as List<dynamic>)
          .map((e) => Fragment$TimeSlotFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      paymentMethods: (l$paymentMethods as List<dynamic>)
          .map((e) => Fragment$PaymentMethodFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$ServiceFields> services;

  final List<Fragment$TimeSlotFields> availableSlots;

  final List<Fragment$PaymentMethodFields> paymentMethods;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$services = services;
    _resultData['services'] = l$services.map((e) => e.toJson()).toList();
    final l$availableSlots = availableSlots;
    _resultData['availableSlots'] = l$availableSlots.map((e) => e.toJson()).toList();
    final l$paymentMethods = paymentMethods;
    _resultData['paymentMethods'] = l$paymentMethods.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$services = services;
    final l$availableSlots = availableSlots;
    final l$paymentMethods = paymentMethods;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$services.map((v) => v)),
      Object.hashAll(l$availableSlots.map((v) => v)),
      Object.hashAll(l$paymentMethods.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$CheckoutCatalog || runtimeType != other.runtimeType) {
      return false;
    }
    final l$services = services;
    final lOther$services = other.services;
    if (l$services.length != lOther$services.length) {
      return false;
    }
    for (int i = 0; i < l$services.length; i++) {
      final l$services$entry = l$services[i];
      final lOther$services$entry = lOther$services[i];
      if (l$services$entry != lOther$services$entry) {
        return false;
      }
    }
    final l$availableSlots = availableSlots;
    final lOther$availableSlots = other.availableSlots;
    if (l$availableSlots.length != lOther$availableSlots.length) {
      return false;
    }
    for (int i = 0; i < l$availableSlots.length; i++) {
      final l$availableSlots$entry = l$availableSlots[i];
      final lOther$availableSlots$entry = lOther$availableSlots[i];
      if (l$availableSlots$entry != lOther$availableSlots$entry) {
        return false;
      }
    }
    final l$paymentMethods = paymentMethods;
    final lOther$paymentMethods = other.paymentMethods;
    if (l$paymentMethods.length != lOther$paymentMethods.length) {
      return false;
    }
    for (int i = 0; i < l$paymentMethods.length; i++) {
      final l$paymentMethods$entry = l$paymentMethods[i];
      final lOther$paymentMethods$entry = lOther$paymentMethods[i];
      if (l$paymentMethods$entry != lOther$paymentMethods$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$CheckoutCatalog on Query$CheckoutCatalog {
  CopyWith$Query$CheckoutCatalog<Query$CheckoutCatalog> get copyWith => CopyWith$Query$CheckoutCatalog(this, (i) => i);
}

abstract class CopyWith$Query$CheckoutCatalog<TRes> {
  factory CopyWith$Query$CheckoutCatalog(Query$CheckoutCatalog instance, TRes Function(Query$CheckoutCatalog) then) =
      _CopyWithImpl$Query$CheckoutCatalog;

  factory CopyWith$Query$CheckoutCatalog.stub(TRes res) = _CopyWithStubImpl$Query$CheckoutCatalog;

  TRes call({
    List<Fragment$ServiceFields>? services,
    List<Fragment$TimeSlotFields>? availableSlots,
    List<Fragment$PaymentMethodFields>? paymentMethods,
    String? $__typename,
  });
  TRes services(
    Iterable<Fragment$ServiceFields> Function(Iterable<CopyWith$Fragment$ServiceFields<Fragment$ServiceFields>>) _fn,
  );
  TRes availableSlots(
    Iterable<Fragment$TimeSlotFields> Function(Iterable<CopyWith$Fragment$TimeSlotFields<Fragment$TimeSlotFields>>) _fn,
  );
  TRes paymentMethods(
    Iterable<Fragment$PaymentMethodFields> Function(
      Iterable<CopyWith$Fragment$PaymentMethodFields<Fragment$PaymentMethodFields>>,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$CheckoutCatalog<TRes> implements CopyWith$Query$CheckoutCatalog<TRes> {
  _CopyWithImpl$Query$CheckoutCatalog(this._instance, this._then);

  final Query$CheckoutCatalog _instance;

  final TRes Function(Query$CheckoutCatalog) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? services = _undefined,
    Object? availableSlots = _undefined,
    Object? paymentMethods = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$CheckoutCatalog(
      services: services == _undefined || services == null
          ? _instance.services
          : (services as List<Fragment$ServiceFields>),
      availableSlots: availableSlots == _undefined || availableSlots == null
          ? _instance.availableSlots
          : (availableSlots as List<Fragment$TimeSlotFields>),
      paymentMethods: paymentMethods == _undefined || paymentMethods == null
          ? _instance.paymentMethods
          : (paymentMethods as List<Fragment$PaymentMethodFields>),
      $__typename: $__typename == _undefined || $__typename == null ? _instance.$__typename : ($__typename as String),
    ),
  );

  TRes services(
    Iterable<Fragment$ServiceFields> Function(Iterable<CopyWith$Fragment$ServiceFields<Fragment$ServiceFields>>) _fn,
  ) => call(services: _fn(_instance.services.map((e) => CopyWith$Fragment$ServiceFields(e, (i) => i))).toList());

  TRes availableSlots(
    Iterable<Fragment$TimeSlotFields> Function(Iterable<CopyWith$Fragment$TimeSlotFields<Fragment$TimeSlotFields>>) _fn,
  ) => call(
    availableSlots: _fn(_instance.availableSlots.map((e) => CopyWith$Fragment$TimeSlotFields(e, (i) => i))).toList(),
  );

  TRes paymentMethods(
    Iterable<Fragment$PaymentMethodFields> Function(
      Iterable<CopyWith$Fragment$PaymentMethodFields<Fragment$PaymentMethodFields>>,
    )
    _fn,
  ) => call(
    paymentMethods: _fn(_instance.paymentMethods.map((e) => CopyWith$Fragment$PaymentMethodFields(e, (i) => i)))
        .toList(),
  );
}

class _CopyWithStubImpl$Query$CheckoutCatalog<TRes> implements CopyWith$Query$CheckoutCatalog<TRes> {
  _CopyWithStubImpl$Query$CheckoutCatalog(this._res);

  TRes _res;

  call({
    List<Fragment$ServiceFields>? services,
    List<Fragment$TimeSlotFields>? availableSlots,
    List<Fragment$PaymentMethodFields>? paymentMethods,
    String? $__typename,
  }) => _res;

  services(_fn) => _res;

  availableSlots(_fn) => _res;

  paymentMethods(_fn) => _res;
}

const documentNodeQueryCheckoutCatalog = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'CheckoutCatalog'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'days')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'services'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'ServiceFields'),
                  directives: [],
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: 'availableSlots'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'days'),
                value: VariableNode(name: NameNode(value: 'days')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'TimeSlotFields'),
                  directives: [],
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: 'paymentMethods'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'PaymentMethodFields'),
                  directives: [],
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionServiceFields,
    fragmentDefinitionTimeSlotFields,
    fragmentDefinitionPaymentMethodFields,
  ],
);
Query$CheckoutCatalog _parserFn$Query$CheckoutCatalog(Map<String, dynamic> data) =>
    Query$CheckoutCatalog.fromJson(data);
typedef OnQueryComplete$Query$CheckoutCatalog = FutureOr<void> Function(Map<String, dynamic>?, Query$CheckoutCatalog?);

class Options$Query$CheckoutCatalog extends graphql.QueryOptions<Query$CheckoutCatalog> {
  Options$Query$CheckoutCatalog({
    String? operationName,
    required Variables$Query$CheckoutCatalog variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$CheckoutCatalog? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$CheckoutCatalog? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFn$Query$CheckoutCatalog(data)),
         onError: onError,
         document: documentNodeQueryCheckoutCatalog,
         parserFn: _parserFn$Query$CheckoutCatalog,
       );

  final OnQueryComplete$Query$CheckoutCatalog? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null ? super.properties : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$CheckoutCatalog extends graphql.WatchQueryOptions<Query$CheckoutCatalog> {
  WatchOptions$Query$CheckoutCatalog({
    String? operationName,
    required Variables$Query$CheckoutCatalog variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$CheckoutCatalog? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryCheckoutCatalog,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$CheckoutCatalog,
       );
}

class FetchMoreOptions$Query$CheckoutCatalog extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$CheckoutCatalog({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$CheckoutCatalog variables,
  }) : super(updateQuery: updateQuery, variables: variables.toJson(), document: documentNodeQueryCheckoutCatalog);
}

extension ClientExtension$Query$CheckoutCatalog on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$CheckoutCatalog>> query$CheckoutCatalog(
    Options$Query$CheckoutCatalog options,
  ) async => await this.query(options);

  graphql.ObservableQuery<Query$CheckoutCatalog> watchQuery$CheckoutCatalog(
    WatchOptions$Query$CheckoutCatalog options,
  ) => this.watchQuery(options);

  void writeQuery$CheckoutCatalog({
    required Query$CheckoutCatalog data,
    required Variables$Query$CheckoutCatalog variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryCheckoutCatalog),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Query$CheckoutCatalog? readQuery$CheckoutCatalog({
    required Variables$Query$CheckoutCatalog variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryCheckoutCatalog),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$CheckoutCatalog.fromJson(result);
  }
}
