import '../../../../../core/graphql/__generated/schema.graphql.dart';
import '../../../../catalog/data/graphql/__generated/catalog.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$OrderFields {
  Fragment$OrderFields({
    required this.id,
    required this.status,
    required this.items,
    required this.slot,
    required this.paymentMethod,
    required this.totalCents,
    required this.currency,
    required this.hold,
    required this.timeline,
    required this.createdAt,
    this.$__typename = 'Order',
  });

  factory Fragment$OrderFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$status = json['status'];
    final l$items = json['items'];
    final l$slot = json['slot'];
    final l$paymentMethod = json['paymentMethod'];
    final l$totalCents = json['totalCents'];
    final l$currency = json['currency'];
    final l$hold = json['hold'];
    final l$timeline = json['timeline'];
    final l$createdAt = json['createdAt'];
    final l$$__typename = json['__typename'];
    return Fragment$OrderFields(
      id: (l$id as String),
      status: fromJson$Enum$OrderStatus((l$status as String)),
      items: (l$items as List<dynamic>)
          .map((e) => Fragment$OrderFields$items.fromJson((e as Map<String, dynamic>)))
          .toList(),
      slot: Fragment$TimeSlotFields.fromJson((l$slot as Map<String, dynamic>)),
      paymentMethod: Fragment$PaymentMethodFields.fromJson((l$paymentMethod as Map<String, dynamic>)),
      totalCents: (l$totalCents as int),
      currency: (l$currency as String),
      hold: Fragment$OrderFields$hold.fromJson((l$hold as Map<String, dynamic>)),
      timeline: (l$timeline as List<dynamic>)
          .map((e) => Fragment$OrderFields$timeline.fromJson((e as Map<String, dynamic>)))
          .toList(),
      createdAt: DateTime.parse((l$createdAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final Enum$OrderStatus status;

  final List<Fragment$OrderFields$items> items;

  final Fragment$TimeSlotFields slot;

  final Fragment$PaymentMethodFields paymentMethod;

  final int totalCents;

  final String currency;

  final Fragment$OrderFields$hold hold;

  final List<Fragment$OrderFields$timeline> timeline;

  final DateTime createdAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$status = status;
    _resultData['status'] = toJson$Enum$OrderStatus(l$status);
    final l$items = items;
    _resultData['items'] = l$items.map((e) => e.toJson()).toList();
    final l$slot = slot;
    _resultData['slot'] = l$slot.toJson();
    final l$paymentMethod = paymentMethod;
    _resultData['paymentMethod'] = l$paymentMethod.toJson();
    final l$totalCents = totalCents;
    _resultData['totalCents'] = l$totalCents;
    final l$currency = currency;
    _resultData['currency'] = l$currency;
    final l$hold = hold;
    _resultData['hold'] = l$hold.toJson();
    final l$timeline = timeline;
    _resultData['timeline'] = l$timeline.map((e) => e.toJson()).toList();
    final l$createdAt = createdAt;
    _resultData['createdAt'] = l$createdAt.toIso8601String();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$status = status;
    final l$items = items;
    final l$slot = slot;
    final l$paymentMethod = paymentMethod;
    final l$totalCents = totalCents;
    final l$currency = currency;
    final l$hold = hold;
    final l$timeline = timeline;
    final l$createdAt = createdAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$status,
      Object.hashAll(l$items.map((v) => v)),
      l$slot,
      l$paymentMethod,
      l$totalCents,
      l$currency,
      l$hold,
      Object.hashAll(l$timeline.map((v) => v)),
      l$createdAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$OrderFields || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$items = items;
    final lOther$items = other.items;
    if (l$items.length != lOther$items.length) {
      return false;
    }
    for (int i = 0; i < l$items.length; i++) {
      final l$items$entry = l$items[i];
      final lOther$items$entry = lOther$items[i];
      if (l$items$entry != lOther$items$entry) {
        return false;
      }
    }
    final l$slot = slot;
    final lOther$slot = other.slot;
    if (l$slot != lOther$slot) {
      return false;
    }
    final l$paymentMethod = paymentMethod;
    final lOther$paymentMethod = other.paymentMethod;
    if (l$paymentMethod != lOther$paymentMethod) {
      return false;
    }
    final l$totalCents = totalCents;
    final lOther$totalCents = other.totalCents;
    if (l$totalCents != lOther$totalCents) {
      return false;
    }
    final l$currency = currency;
    final lOther$currency = other.currency;
    if (l$currency != lOther$currency) {
      return false;
    }
    final l$hold = hold;
    final lOther$hold = other.hold;
    if (l$hold != lOther$hold) {
      return false;
    }
    final l$timeline = timeline;
    final lOther$timeline = other.timeline;
    if (l$timeline.length != lOther$timeline.length) {
      return false;
    }
    for (int i = 0; i < l$timeline.length; i++) {
      final l$timeline$entry = l$timeline[i];
      final lOther$timeline$entry = lOther$timeline[i];
      if (l$timeline$entry != lOther$timeline$entry) {
        return false;
      }
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
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

extension UtilityExtension$Fragment$OrderFields on Fragment$OrderFields {
  CopyWith$Fragment$OrderFields<Fragment$OrderFields> get copyWith => CopyWith$Fragment$OrderFields(this, (i) => i);
}

abstract class CopyWith$Fragment$OrderFields<TRes> {
  factory CopyWith$Fragment$OrderFields(Fragment$OrderFields instance, TRes Function(Fragment$OrderFields) then) =
      _CopyWithImpl$Fragment$OrderFields;

  factory CopyWith$Fragment$OrderFields.stub(TRes res) = _CopyWithStubImpl$Fragment$OrderFields;

  TRes call({
    String? id,
    Enum$OrderStatus? status,
    List<Fragment$OrderFields$items>? items,
    Fragment$TimeSlotFields? slot,
    Fragment$PaymentMethodFields? paymentMethod,
    int? totalCents,
    String? currency,
    Fragment$OrderFields$hold? hold,
    List<Fragment$OrderFields$timeline>? timeline,
    DateTime? createdAt,
    String? $__typename,
  });
  TRes items(
    Iterable<Fragment$OrderFields$items> Function(
      Iterable<CopyWith$Fragment$OrderFields$items<Fragment$OrderFields$items>>,
    )
    _fn,
  );
  CopyWith$Fragment$TimeSlotFields<TRes> get slot;
  CopyWith$Fragment$PaymentMethodFields<TRes> get paymentMethod;
  CopyWith$Fragment$OrderFields$hold<TRes> get hold;
  TRes timeline(
    Iterable<Fragment$OrderFields$timeline> Function(
      Iterable<CopyWith$Fragment$OrderFields$timeline<Fragment$OrderFields$timeline>>,
    )
    _fn,
  );
}

class _CopyWithImpl$Fragment$OrderFields<TRes> implements CopyWith$Fragment$OrderFields<TRes> {
  _CopyWithImpl$Fragment$OrderFields(this._instance, this._then);

  final Fragment$OrderFields _instance;

  final TRes Function(Fragment$OrderFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? status = _undefined,
    Object? items = _undefined,
    Object? slot = _undefined,
    Object? paymentMethod = _undefined,
    Object? totalCents = _undefined,
    Object? currency = _undefined,
    Object? hold = _undefined,
    Object? timeline = _undefined,
    Object? createdAt = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$OrderFields(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      status: status == _undefined || status == null ? _instance.status : (status as Enum$OrderStatus),
      items: items == _undefined || items == null ? _instance.items : (items as List<Fragment$OrderFields$items>),
      slot: slot == _undefined || slot == null ? _instance.slot : (slot as Fragment$TimeSlotFields),
      paymentMethod: paymentMethod == _undefined || paymentMethod == null
          ? _instance.paymentMethod
          : (paymentMethod as Fragment$PaymentMethodFields),
      totalCents: totalCents == _undefined || totalCents == null ? _instance.totalCents : (totalCents as int),
      currency: currency == _undefined || currency == null ? _instance.currency : (currency as String),
      hold: hold == _undefined || hold == null ? _instance.hold : (hold as Fragment$OrderFields$hold),
      timeline: timeline == _undefined || timeline == null
          ? _instance.timeline
          : (timeline as List<Fragment$OrderFields$timeline>),
      createdAt: createdAt == _undefined || createdAt == null ? _instance.createdAt : (createdAt as DateTime),
      $__typename: $__typename == _undefined || $__typename == null ? _instance.$__typename : ($__typename as String),
    ),
  );

  TRes items(
    Iterable<Fragment$OrderFields$items> Function(
      Iterable<CopyWith$Fragment$OrderFields$items<Fragment$OrderFields$items>>,
    )
    _fn,
  ) => call(items: _fn(_instance.items.map((e) => CopyWith$Fragment$OrderFields$items(e, (i) => i))).toList());

  CopyWith$Fragment$TimeSlotFields<TRes> get slot {
    final local$slot = _instance.slot;
    return CopyWith$Fragment$TimeSlotFields(local$slot, (e) => call(slot: e));
  }

  CopyWith$Fragment$PaymentMethodFields<TRes> get paymentMethod {
    final local$paymentMethod = _instance.paymentMethod;
    return CopyWith$Fragment$PaymentMethodFields(local$paymentMethod, (e) => call(paymentMethod: e));
  }

  CopyWith$Fragment$OrderFields$hold<TRes> get hold {
    final local$hold = _instance.hold;
    return CopyWith$Fragment$OrderFields$hold(local$hold, (e) => call(hold: e));
  }

  TRes timeline(
    Iterable<Fragment$OrderFields$timeline> Function(
      Iterable<CopyWith$Fragment$OrderFields$timeline<Fragment$OrderFields$timeline>>,
    )
    _fn,
  ) => call(timeline: _fn(_instance.timeline.map((e) => CopyWith$Fragment$OrderFields$timeline(e, (i) => i))).toList());
}

class _CopyWithStubImpl$Fragment$OrderFields<TRes> implements CopyWith$Fragment$OrderFields<TRes> {
  _CopyWithStubImpl$Fragment$OrderFields(this._res);

  TRes _res;

  call({
    String? id,
    Enum$OrderStatus? status,
    List<Fragment$OrderFields$items>? items,
    Fragment$TimeSlotFields? slot,
    Fragment$PaymentMethodFields? paymentMethod,
    int? totalCents,
    String? currency,
    Fragment$OrderFields$hold? hold,
    List<Fragment$OrderFields$timeline>? timeline,
    DateTime? createdAt,
    String? $__typename,
  }) => _res;

  items(_fn) => _res;

  CopyWith$Fragment$TimeSlotFields<TRes> get slot => CopyWith$Fragment$TimeSlotFields.stub(_res);

  CopyWith$Fragment$PaymentMethodFields<TRes> get paymentMethod => CopyWith$Fragment$PaymentMethodFields.stub(_res);

  CopyWith$Fragment$OrderFields$hold<TRes> get hold => CopyWith$Fragment$OrderFields$hold.stub(_res);

  timeline(_fn) => _res;
}

const fragmentDefinitionOrderFields = FragmentDefinitionNode(
  name: NameNode(value: 'OrderFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Order'), isNonNull: false),
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
        name: NameNode(value: 'status'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'items'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FieldNode(
              name: NameNode(value: 'serviceId'),
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
              name: NameNode(value: 'priceCents'),
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
      ),
      FieldNode(
        name: NameNode(value: 'slot'),
        alias: null,
        arguments: [],
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
        name: NameNode(value: 'paymentMethod'),
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
        name: NameNode(value: 'totalCents'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'currency'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'hold'),
        alias: null,
        arguments: [],
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
              name: NameNode(value: 'status'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'amountCents'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'provider'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'paymentType'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'reference'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'resultCode'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'resultDescription'),
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
      ),
      FieldNode(
        name: NameNode(value: 'timeline'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FieldNode(
              name: NameNode(value: 'type'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'at'),
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
      ),
      FieldNode(
        name: NameNode(value: 'createdAt'),
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
const documentNodeFragmentOrderFields = DocumentNode(
  definitions: [fragmentDefinitionOrderFields, fragmentDefinitionTimeSlotFields, fragmentDefinitionPaymentMethodFields],
);

extension ClientExtension$Fragment$OrderFields on graphql.GraphQLClient {
  void writeFragment$OrderFields({
    required Fragment$OrderFields data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(fragmentName: 'OrderFields', document: documentNodeFragmentOrderFields),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$OrderFields? readFragment$OrderFields({required Map<String, dynamic> idFields, bool optimistic = true}) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(fragmentName: 'OrderFields', document: documentNodeFragmentOrderFields),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$OrderFields.fromJson(result);
  }
}

class Fragment$OrderFields$items {
  Fragment$OrderFields$items({
    required this.serviceId,
    required this.name,
    required this.priceCents,
    this.$__typename = 'OrderItem',
  });

  factory Fragment$OrderFields$items.fromJson(Map<String, dynamic> json) {
    final l$serviceId = json['serviceId'];
    final l$name = json['name'];
    final l$priceCents = json['priceCents'];
    final l$$__typename = json['__typename'];
    return Fragment$OrderFields$items(
      serviceId: (l$serviceId as String),
      name: (l$name as String),
      priceCents: (l$priceCents as int),
      $__typename: (l$$__typename as String),
    );
  }

  final String serviceId;

  final String name;

  final int priceCents;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$serviceId = serviceId;
    _resultData['serviceId'] = l$serviceId;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$priceCents = priceCents;
    _resultData['priceCents'] = l$priceCents;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$serviceId = serviceId;
    final l$name = name;
    final l$priceCents = priceCents;
    final l$$__typename = $__typename;
    return Object.hashAll([l$serviceId, l$name, l$priceCents, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$OrderFields$items || runtimeType != other.runtimeType) {
      return false;
    }
    final l$serviceId = serviceId;
    final lOther$serviceId = other.serviceId;
    if (l$serviceId != lOther$serviceId) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$priceCents = priceCents;
    final lOther$priceCents = other.priceCents;
    if (l$priceCents != lOther$priceCents) {
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

extension UtilityExtension$Fragment$OrderFields$items on Fragment$OrderFields$items {
  CopyWith$Fragment$OrderFields$items<Fragment$OrderFields$items> get copyWith =>
      CopyWith$Fragment$OrderFields$items(this, (i) => i);
}

abstract class CopyWith$Fragment$OrderFields$items<TRes> {
  factory CopyWith$Fragment$OrderFields$items(
    Fragment$OrderFields$items instance,
    TRes Function(Fragment$OrderFields$items) then,
  ) = _CopyWithImpl$Fragment$OrderFields$items;

  factory CopyWith$Fragment$OrderFields$items.stub(TRes res) = _CopyWithStubImpl$Fragment$OrderFields$items;

  TRes call({String? serviceId, String? name, int? priceCents, String? $__typename});
}

class _CopyWithImpl$Fragment$OrderFields$items<TRes> implements CopyWith$Fragment$OrderFields$items<TRes> {
  _CopyWithImpl$Fragment$OrderFields$items(this._instance, this._then);

  final Fragment$OrderFields$items _instance;

  final TRes Function(Fragment$OrderFields$items) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? serviceId = _undefined,
    Object? name = _undefined,
    Object? priceCents = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$OrderFields$items(
      serviceId: serviceId == _undefined || serviceId == null ? _instance.serviceId : (serviceId as String),
      name: name == _undefined || name == null ? _instance.name : (name as String),
      priceCents: priceCents == _undefined || priceCents == null ? _instance.priceCents : (priceCents as int),
      $__typename: $__typename == _undefined || $__typename == null ? _instance.$__typename : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$OrderFields$items<TRes> implements CopyWith$Fragment$OrderFields$items<TRes> {
  _CopyWithStubImpl$Fragment$OrderFields$items(this._res);

  TRes _res;

  call({String? serviceId, String? name, int? priceCents, String? $__typename}) => _res;
}

class Fragment$OrderFields$hold {
  Fragment$OrderFields$hold({
    required this.id,
    required this.status,
    required this.amountCents,
    required this.provider,
    required this.paymentType,
    required this.reference,
    required this.resultCode,
    required this.resultDescription,
    this.$__typename = 'PaymentHold',
  });

  factory Fragment$OrderFields$hold.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$status = json['status'];
    final l$amountCents = json['amountCents'];
    final l$provider = json['provider'];
    final l$paymentType = json['paymentType'];
    final l$reference = json['reference'];
    final l$resultCode = json['resultCode'];
    final l$resultDescription = json['resultDescription'];
    final l$$__typename = json['__typename'];
    return Fragment$OrderFields$hold(
      id: (l$id as String),
      status: fromJson$Enum$HoldStatus((l$status as String)),
      amountCents: (l$amountCents as int),
      provider: (l$provider as String),
      paymentType: (l$paymentType as String),
      reference: (l$reference as String),
      resultCode: (l$resultCode as String),
      resultDescription: (l$resultDescription as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final Enum$HoldStatus status;

  final int amountCents;

  final String provider;

  final String paymentType;

  final String reference;

  final String resultCode;

  final String resultDescription;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$status = status;
    _resultData['status'] = toJson$Enum$HoldStatus(l$status);
    final l$amountCents = amountCents;
    _resultData['amountCents'] = l$amountCents;
    final l$provider = provider;
    _resultData['provider'] = l$provider;
    final l$paymentType = paymentType;
    _resultData['paymentType'] = l$paymentType;
    final l$reference = reference;
    _resultData['reference'] = l$reference;
    final l$resultCode = resultCode;
    _resultData['resultCode'] = l$resultCode;
    final l$resultDescription = resultDescription;
    _resultData['resultDescription'] = l$resultDescription;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$status = status;
    final l$amountCents = amountCents;
    final l$provider = provider;
    final l$paymentType = paymentType;
    final l$reference = reference;
    final l$resultCode = resultCode;
    final l$resultDescription = resultDescription;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$status,
      l$amountCents,
      l$provider,
      l$paymentType,
      l$reference,
      l$resultCode,
      l$resultDescription,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$OrderFields$hold || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$amountCents = amountCents;
    final lOther$amountCents = other.amountCents;
    if (l$amountCents != lOther$amountCents) {
      return false;
    }
    final l$provider = provider;
    final lOther$provider = other.provider;
    if (l$provider != lOther$provider) {
      return false;
    }
    final l$paymentType = paymentType;
    final lOther$paymentType = other.paymentType;
    if (l$paymentType != lOther$paymentType) {
      return false;
    }
    final l$reference = reference;
    final lOther$reference = other.reference;
    if (l$reference != lOther$reference) {
      return false;
    }
    final l$resultCode = resultCode;
    final lOther$resultCode = other.resultCode;
    if (l$resultCode != lOther$resultCode) {
      return false;
    }
    final l$resultDescription = resultDescription;
    final lOther$resultDescription = other.resultDescription;
    if (l$resultDescription != lOther$resultDescription) {
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

extension UtilityExtension$Fragment$OrderFields$hold on Fragment$OrderFields$hold {
  CopyWith$Fragment$OrderFields$hold<Fragment$OrderFields$hold> get copyWith =>
      CopyWith$Fragment$OrderFields$hold(this, (i) => i);
}

abstract class CopyWith$Fragment$OrderFields$hold<TRes> {
  factory CopyWith$Fragment$OrderFields$hold(
    Fragment$OrderFields$hold instance,
    TRes Function(Fragment$OrderFields$hold) then,
  ) = _CopyWithImpl$Fragment$OrderFields$hold;

  factory CopyWith$Fragment$OrderFields$hold.stub(TRes res) = _CopyWithStubImpl$Fragment$OrderFields$hold;

  TRes call({
    String? id,
    Enum$HoldStatus? status,
    int? amountCents,
    String? provider,
    String? paymentType,
    String? reference,
    String? resultCode,
    String? resultDescription,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$OrderFields$hold<TRes> implements CopyWith$Fragment$OrderFields$hold<TRes> {
  _CopyWithImpl$Fragment$OrderFields$hold(this._instance, this._then);

  final Fragment$OrderFields$hold _instance;

  final TRes Function(Fragment$OrderFields$hold) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? status = _undefined,
    Object? amountCents = _undefined,
    Object? provider = _undefined,
    Object? paymentType = _undefined,
    Object? reference = _undefined,
    Object? resultCode = _undefined,
    Object? resultDescription = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$OrderFields$hold(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      status: status == _undefined || status == null ? _instance.status : (status as Enum$HoldStatus),
      amountCents: amountCents == _undefined || amountCents == null ? _instance.amountCents : (amountCents as int),
      provider: provider == _undefined || provider == null ? _instance.provider : (provider as String),
      paymentType: paymentType == _undefined || paymentType == null ? _instance.paymentType : (paymentType as String),
      reference: reference == _undefined || reference == null ? _instance.reference : (reference as String),
      resultCode: resultCode == _undefined || resultCode == null ? _instance.resultCode : (resultCode as String),
      resultDescription: resultDescription == _undefined || resultDescription == null
          ? _instance.resultDescription
          : (resultDescription as String),
      $__typename: $__typename == _undefined || $__typename == null ? _instance.$__typename : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$OrderFields$hold<TRes> implements CopyWith$Fragment$OrderFields$hold<TRes> {
  _CopyWithStubImpl$Fragment$OrderFields$hold(this._res);

  TRes _res;

  call({
    String? id,
    Enum$HoldStatus? status,
    int? amountCents,
    String? provider,
    String? paymentType,
    String? reference,
    String? resultCode,
    String? resultDescription,
    String? $__typename,
  }) => _res;
}

class Fragment$OrderFields$timeline {
  Fragment$OrderFields$timeline({required this.type, required this.at, this.$__typename = 'TimelineEvent'});

  factory Fragment$OrderFields$timeline.fromJson(Map<String, dynamic> json) {
    final l$type = json['type'];
    final l$at = json['at'];
    final l$$__typename = json['__typename'];
    return Fragment$OrderFields$timeline(
      type: fromJson$Enum$TimelineEventType((l$type as String)),
      at: DateTime.parse((l$at as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final Enum$TimelineEventType type;

  final DateTime at;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$type = type;
    _resultData['type'] = toJson$Enum$TimelineEventType(l$type);
    final l$at = at;
    _resultData['at'] = l$at.toIso8601String();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$type = type;
    final l$at = at;
    final l$$__typename = $__typename;
    return Object.hashAll([l$type, l$at, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$OrderFields$timeline || runtimeType != other.runtimeType) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
      return false;
    }
    final l$at = at;
    final lOther$at = other.at;
    if (l$at != lOther$at) {
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

extension UtilityExtension$Fragment$OrderFields$timeline on Fragment$OrderFields$timeline {
  CopyWith$Fragment$OrderFields$timeline<Fragment$OrderFields$timeline> get copyWith =>
      CopyWith$Fragment$OrderFields$timeline(this, (i) => i);
}

abstract class CopyWith$Fragment$OrderFields$timeline<TRes> {
  factory CopyWith$Fragment$OrderFields$timeline(
    Fragment$OrderFields$timeline instance,
    TRes Function(Fragment$OrderFields$timeline) then,
  ) = _CopyWithImpl$Fragment$OrderFields$timeline;

  factory CopyWith$Fragment$OrderFields$timeline.stub(TRes res) = _CopyWithStubImpl$Fragment$OrderFields$timeline;

  TRes call({Enum$TimelineEventType? type, DateTime? at, String? $__typename});
}

class _CopyWithImpl$Fragment$OrderFields$timeline<TRes> implements CopyWith$Fragment$OrderFields$timeline<TRes> {
  _CopyWithImpl$Fragment$OrderFields$timeline(this._instance, this._then);

  final Fragment$OrderFields$timeline _instance;

  final TRes Function(Fragment$OrderFields$timeline) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? type = _undefined, Object? at = _undefined, Object? $__typename = _undefined}) => _then(
    Fragment$OrderFields$timeline(
      type: type == _undefined || type == null ? _instance.type : (type as Enum$TimelineEventType),
      at: at == _undefined || at == null ? _instance.at : (at as DateTime),
      $__typename: $__typename == _undefined || $__typename == null ? _instance.$__typename : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$OrderFields$timeline<TRes> implements CopyWith$Fragment$OrderFields$timeline<TRes> {
  _CopyWithStubImpl$Fragment$OrderFields$timeline(this._res);

  TRes _res;

  call({Enum$TimelineEventType? type, DateTime? at, String? $__typename}) => _res;
}

class Variables$Mutation$CreateOrder {
  factory Variables$Mutation$CreateOrder({required Input$CreateOrderInput input}) =>
      Variables$Mutation$CreateOrder._({r'input': input});

  Variables$Mutation$CreateOrder._(this._$data);

  factory Variables$Mutation$CreateOrder.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$CreateOrderInput.fromJson((l$input as Map<String, dynamic>));
    return Variables$Mutation$CreateOrder._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$CreateOrderInput get input => (_$data['input'] as Input$CreateOrderInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$CreateOrder<Variables$Mutation$CreateOrder> get copyWith =>
      CopyWith$Variables$Mutation$CreateOrder(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$CreateOrder || runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$CreateOrder<TRes> {
  factory CopyWith$Variables$Mutation$CreateOrder(
    Variables$Mutation$CreateOrder instance,
    TRes Function(Variables$Mutation$CreateOrder) then,
  ) = _CopyWithImpl$Variables$Mutation$CreateOrder;

  factory CopyWith$Variables$Mutation$CreateOrder.stub(TRes res) = _CopyWithStubImpl$Variables$Mutation$CreateOrder;

  TRes call({Input$CreateOrderInput? input});
}

class _CopyWithImpl$Variables$Mutation$CreateOrder<TRes> implements CopyWith$Variables$Mutation$CreateOrder<TRes> {
  _CopyWithImpl$Variables$Mutation$CreateOrder(this._instance, this._then);

  final Variables$Mutation$CreateOrder _instance;

  final TRes Function(Variables$Mutation$CreateOrder) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) => _then(
    Variables$Mutation$CreateOrder._({
      ..._instance._$data,
      if (input != _undefined && input != null) 'input': (input as Input$CreateOrderInput),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$CreateOrder<TRes> implements CopyWith$Variables$Mutation$CreateOrder<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreateOrder(this._res);

  TRes _res;

  call({Input$CreateOrderInput? input}) => _res;
}

class Mutation$CreateOrder {
  Mutation$CreateOrder({required this.createOrder, this.$__typename = 'Mutation'});

  factory Mutation$CreateOrder.fromJson(Map<String, dynamic> json) {
    final l$createOrder = json['createOrder'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateOrder(
      createOrder: Mutation$CreateOrder$createOrder.fromJson((l$createOrder as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$CreateOrder$createOrder createOrder;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createOrder = createOrder;
    _resultData['createOrder'] = l$createOrder.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createOrder = createOrder;
    final l$$__typename = $__typename;
    return Object.hashAll([l$createOrder, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$CreateOrder || runtimeType != other.runtimeType) {
      return false;
    }
    final l$createOrder = createOrder;
    final lOther$createOrder = other.createOrder;
    if (l$createOrder != lOther$createOrder) {
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

extension UtilityExtension$Mutation$CreateOrder on Mutation$CreateOrder {
  CopyWith$Mutation$CreateOrder<Mutation$CreateOrder> get copyWith => CopyWith$Mutation$CreateOrder(this, (i) => i);
}

abstract class CopyWith$Mutation$CreateOrder<TRes> {
  factory CopyWith$Mutation$CreateOrder(Mutation$CreateOrder instance, TRes Function(Mutation$CreateOrder) then) =
      _CopyWithImpl$Mutation$CreateOrder;

  factory CopyWith$Mutation$CreateOrder.stub(TRes res) = _CopyWithStubImpl$Mutation$CreateOrder;

  TRes call({Mutation$CreateOrder$createOrder? createOrder, String? $__typename});
  CopyWith$Mutation$CreateOrder$createOrder<TRes> get createOrder;
}

class _CopyWithImpl$Mutation$CreateOrder<TRes> implements CopyWith$Mutation$CreateOrder<TRes> {
  _CopyWithImpl$Mutation$CreateOrder(this._instance, this._then);

  final Mutation$CreateOrder _instance;

  final TRes Function(Mutation$CreateOrder) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? createOrder = _undefined, Object? $__typename = _undefined}) => _then(
    Mutation$CreateOrder(
      createOrder: createOrder == _undefined || createOrder == null
          ? _instance.createOrder
          : (createOrder as Mutation$CreateOrder$createOrder),
      $__typename: $__typename == _undefined || $__typename == null ? _instance.$__typename : ($__typename as String),
    ),
  );

  CopyWith$Mutation$CreateOrder$createOrder<TRes> get createOrder {
    final local$createOrder = _instance.createOrder;
    return CopyWith$Mutation$CreateOrder$createOrder(local$createOrder, (e) => call(createOrder: e));
  }
}

class _CopyWithStubImpl$Mutation$CreateOrder<TRes> implements CopyWith$Mutation$CreateOrder<TRes> {
  _CopyWithStubImpl$Mutation$CreateOrder(this._res);

  TRes _res;

  call({Mutation$CreateOrder$createOrder? createOrder, String? $__typename}) => _res;

  CopyWith$Mutation$CreateOrder$createOrder<TRes> get createOrder =>
      CopyWith$Mutation$CreateOrder$createOrder.stub(_res);
}

const documentNodeMutationCreateOrder = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'CreateOrder'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'input')),
          type: NamedTypeNode(name: NameNode(value: 'CreateOrderInput'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'createOrder'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'input'),
                value: VariableNode(name: NameNode(value: 'input')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'replayed'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'order'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'OrderFields'),
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
    fragmentDefinitionOrderFields,
    fragmentDefinitionTimeSlotFields,
    fragmentDefinitionPaymentMethodFields,
  ],
);
Mutation$CreateOrder _parserFn$Mutation$CreateOrder(Map<String, dynamic> data) => Mutation$CreateOrder.fromJson(data);
typedef OnMutationCompleted$Mutation$CreateOrder = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$CreateOrder?,
);

class Options$Mutation$CreateOrder extends graphql.MutationOptions<Mutation$CreateOrder> {
  Options$Mutation$CreateOrder({
    String? operationName,
    required Variables$Mutation$CreateOrder variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateOrder? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateOrder? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateOrder>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(data, data == null ? null : _parserFn$Mutation$CreateOrder(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationCreateOrder,
         parserFn: _parserFn$Mutation$CreateOrder,
       );

  final OnMutationCompleted$Mutation$CreateOrder? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null ? super.properties : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$CreateOrder extends graphql.WatchQueryOptions<Mutation$CreateOrder> {
  WatchOptions$Mutation$CreateOrder({
    String? operationName,
    required Variables$Mutation$CreateOrder variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateOrder? typedOptimisticResult,
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
         document: documentNodeMutationCreateOrder,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$CreateOrder,
       );
}

extension ClientExtension$Mutation$CreateOrder on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$CreateOrder>> mutate$CreateOrder(Options$Mutation$CreateOrder options) async =>
      await this.mutate(options);

  graphql.ObservableQuery<Mutation$CreateOrder> watchMutation$CreateOrder(WatchOptions$Mutation$CreateOrder options) =>
      this.watchMutation(options);
}

class Mutation$CreateOrder$createOrder {
  Mutation$CreateOrder$createOrder({
    required this.replayed,
    required this.order,
    this.$__typename = 'CreateOrderPayload',
  });

  factory Mutation$CreateOrder$createOrder.fromJson(Map<String, dynamic> json) {
    final l$replayed = json['replayed'];
    final l$order = json['order'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateOrder$createOrder(
      replayed: (l$replayed as bool),
      order: Fragment$OrderFields.fromJson((l$order as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final bool replayed;

  final Fragment$OrderFields order;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$replayed = replayed;
    _resultData['replayed'] = l$replayed;
    final l$order = order;
    _resultData['order'] = l$order.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$replayed = replayed;
    final l$order = order;
    final l$$__typename = $__typename;
    return Object.hashAll([l$replayed, l$order, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$CreateOrder$createOrder || runtimeType != other.runtimeType) {
      return false;
    }
    final l$replayed = replayed;
    final lOther$replayed = other.replayed;
    if (l$replayed != lOther$replayed) {
      return false;
    }
    final l$order = order;
    final lOther$order = other.order;
    if (l$order != lOther$order) {
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

extension UtilityExtension$Mutation$CreateOrder$createOrder on Mutation$CreateOrder$createOrder {
  CopyWith$Mutation$CreateOrder$createOrder<Mutation$CreateOrder$createOrder> get copyWith =>
      CopyWith$Mutation$CreateOrder$createOrder(this, (i) => i);
}

abstract class CopyWith$Mutation$CreateOrder$createOrder<TRes> {
  factory CopyWith$Mutation$CreateOrder$createOrder(
    Mutation$CreateOrder$createOrder instance,
    TRes Function(Mutation$CreateOrder$createOrder) then,
  ) = _CopyWithImpl$Mutation$CreateOrder$createOrder;

  factory CopyWith$Mutation$CreateOrder$createOrder.stub(TRes res) = _CopyWithStubImpl$Mutation$CreateOrder$createOrder;

  TRes call({bool? replayed, Fragment$OrderFields? order, String? $__typename});
  CopyWith$Fragment$OrderFields<TRes> get order;
}

class _CopyWithImpl$Mutation$CreateOrder$createOrder<TRes> implements CopyWith$Mutation$CreateOrder$createOrder<TRes> {
  _CopyWithImpl$Mutation$CreateOrder$createOrder(this._instance, this._then);

  final Mutation$CreateOrder$createOrder _instance;

  final TRes Function(Mutation$CreateOrder$createOrder) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? replayed = _undefined, Object? order = _undefined, Object? $__typename = _undefined}) => _then(
    Mutation$CreateOrder$createOrder(
      replayed: replayed == _undefined || replayed == null ? _instance.replayed : (replayed as bool),
      order: order == _undefined || order == null ? _instance.order : (order as Fragment$OrderFields),
      $__typename: $__typename == _undefined || $__typename == null ? _instance.$__typename : ($__typename as String),
    ),
  );

  CopyWith$Fragment$OrderFields<TRes> get order {
    final local$order = _instance.order;
    return CopyWith$Fragment$OrderFields(local$order, (e) => call(order: e));
  }
}

class _CopyWithStubImpl$Mutation$CreateOrder$createOrder<TRes>
    implements CopyWith$Mutation$CreateOrder$createOrder<TRes> {
  _CopyWithStubImpl$Mutation$CreateOrder$createOrder(this._res);

  TRes _res;

  call({bool? replayed, Fragment$OrderFields? order, String? $__typename}) => _res;

  CopyWith$Fragment$OrderFields<TRes> get order => CopyWith$Fragment$OrderFields.stub(_res);
}

class Variables$Query$OrderDetails {
  factory Variables$Query$OrderDetails({required String id}) => Variables$Query$OrderDetails._({r'id': id});

  Variables$Query$OrderDetails._(this._$data);

  factory Variables$Query$OrderDetails.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return Variables$Query$OrderDetails._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  CopyWith$Variables$Query$OrderDetails<Variables$Query$OrderDetails> get copyWith =>
      CopyWith$Variables$Query$OrderDetails(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$OrderDetails || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }
}

abstract class CopyWith$Variables$Query$OrderDetails<TRes> {
  factory CopyWith$Variables$Query$OrderDetails(
    Variables$Query$OrderDetails instance,
    TRes Function(Variables$Query$OrderDetails) then,
  ) = _CopyWithImpl$Variables$Query$OrderDetails;

  factory CopyWith$Variables$Query$OrderDetails.stub(TRes res) = _CopyWithStubImpl$Variables$Query$OrderDetails;

  TRes call({String? id});
}

class _CopyWithImpl$Variables$Query$OrderDetails<TRes> implements CopyWith$Variables$Query$OrderDetails<TRes> {
  _CopyWithImpl$Variables$Query$OrderDetails(this._instance, this._then);

  final Variables$Query$OrderDetails _instance;

  final TRes Function(Variables$Query$OrderDetails) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined}) => _then(
    Variables$Query$OrderDetails._({..._instance._$data, if (id != _undefined && id != null) 'id': (id as String)}),
  );
}

class _CopyWithStubImpl$Variables$Query$OrderDetails<TRes> implements CopyWith$Variables$Query$OrderDetails<TRes> {
  _CopyWithStubImpl$Variables$Query$OrderDetails(this._res);

  TRes _res;

  call({String? id}) => _res;
}

class Query$OrderDetails {
  Query$OrderDetails({this.order, this.$__typename = 'Query'});

  factory Query$OrderDetails.fromJson(Map<String, dynamic> json) {
    final l$order = json['order'];
    final l$$__typename = json['__typename'];
    return Query$OrderDetails(
      order: l$order == null ? null : Fragment$OrderFields.fromJson((l$order as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$OrderFields? order;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$order = order;
    _resultData['order'] = l$order?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$order = order;
    final l$$__typename = $__typename;
    return Object.hashAll([l$order, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$OrderDetails || runtimeType != other.runtimeType) {
      return false;
    }
    final l$order = order;
    final lOther$order = other.order;
    if (l$order != lOther$order) {
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

extension UtilityExtension$Query$OrderDetails on Query$OrderDetails {
  CopyWith$Query$OrderDetails<Query$OrderDetails> get copyWith => CopyWith$Query$OrderDetails(this, (i) => i);
}

abstract class CopyWith$Query$OrderDetails<TRes> {
  factory CopyWith$Query$OrderDetails(Query$OrderDetails instance, TRes Function(Query$OrderDetails) then) =
      _CopyWithImpl$Query$OrderDetails;

  factory CopyWith$Query$OrderDetails.stub(TRes res) = _CopyWithStubImpl$Query$OrderDetails;

  TRes call({Fragment$OrderFields? order, String? $__typename});
  CopyWith$Fragment$OrderFields<TRes> get order;
}

class _CopyWithImpl$Query$OrderDetails<TRes> implements CopyWith$Query$OrderDetails<TRes> {
  _CopyWithImpl$Query$OrderDetails(this._instance, this._then);

  final Query$OrderDetails _instance;

  final TRes Function(Query$OrderDetails) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? order = _undefined, Object? $__typename = _undefined}) => _then(
    Query$OrderDetails(
      order: order == _undefined ? _instance.order : (order as Fragment$OrderFields?),
      $__typename: $__typename == _undefined || $__typename == null ? _instance.$__typename : ($__typename as String),
    ),
  );

  CopyWith$Fragment$OrderFields<TRes> get order {
    final local$order = _instance.order;
    return local$order == null
        ? CopyWith$Fragment$OrderFields.stub(_then(_instance))
        : CopyWith$Fragment$OrderFields(local$order, (e) => call(order: e));
  }
}

class _CopyWithStubImpl$Query$OrderDetails<TRes> implements CopyWith$Query$OrderDetails<TRes> {
  _CopyWithStubImpl$Query$OrderDetails(this._res);

  TRes _res;

  call({Fragment$OrderFields? order, String? $__typename}) => _res;

  CopyWith$Fragment$OrderFields<TRes> get order => CopyWith$Fragment$OrderFields.stub(_res);
}

const documentNodeQueryOrderDetails = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'OrderDetails'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'order'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'OrderFields'),
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
    fragmentDefinitionOrderFields,
    fragmentDefinitionTimeSlotFields,
    fragmentDefinitionPaymentMethodFields,
  ],
);
Query$OrderDetails _parserFn$Query$OrderDetails(Map<String, dynamic> data) => Query$OrderDetails.fromJson(data);
typedef OnQueryComplete$Query$OrderDetails = FutureOr<void> Function(Map<String, dynamic>?, Query$OrderDetails?);

class Options$Query$OrderDetails extends graphql.QueryOptions<Query$OrderDetails> {
  Options$Query$OrderDetails({
    String? operationName,
    required Variables$Query$OrderDetails variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$OrderDetails? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$OrderDetails? onComplete,
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
             : (data) => onComplete(data, data == null ? null : _parserFn$Query$OrderDetails(data)),
         onError: onError,
         document: documentNodeQueryOrderDetails,
         parserFn: _parserFn$Query$OrderDetails,
       );

  final OnQueryComplete$Query$OrderDetails? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null ? super.properties : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$OrderDetails extends graphql.WatchQueryOptions<Query$OrderDetails> {
  WatchOptions$Query$OrderDetails({
    String? operationName,
    required Variables$Query$OrderDetails variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$OrderDetails? typedOptimisticResult,
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
         document: documentNodeQueryOrderDetails,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$OrderDetails,
       );
}

class FetchMoreOptions$Query$OrderDetails extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$OrderDetails({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$OrderDetails variables,
  }) : super(updateQuery: updateQuery, variables: variables.toJson(), document: documentNodeQueryOrderDetails);
}

extension ClientExtension$Query$OrderDetails on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$OrderDetails>> query$OrderDetails(Options$Query$OrderDetails options) async =>
      await this.query(options);

  graphql.ObservableQuery<Query$OrderDetails> watchQuery$OrderDetails(WatchOptions$Query$OrderDetails options) =>
      this.watchQuery(options);

  void writeQuery$OrderDetails({
    required Query$OrderDetails data,
    required Variables$Query$OrderDetails variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryOrderDetails),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Query$OrderDetails? readQuery$OrderDetails({
    required Variables$Query$OrderDetails variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryOrderDetails),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$OrderDetails.fromJson(result);
  }
}

class Variables$Subscription$OrderUpdated {
  factory Variables$Subscription$OrderUpdated({required String id}) =>
      Variables$Subscription$OrderUpdated._({r'id': id});

  Variables$Subscription$OrderUpdated._(this._$data);

  factory Variables$Subscription$OrderUpdated.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return Variables$Subscription$OrderUpdated._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  CopyWith$Variables$Subscription$OrderUpdated<Variables$Subscription$OrderUpdated> get copyWith =>
      CopyWith$Variables$Subscription$OrderUpdated(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Subscription$OrderUpdated || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }
}

abstract class CopyWith$Variables$Subscription$OrderUpdated<TRes> {
  factory CopyWith$Variables$Subscription$OrderUpdated(
    Variables$Subscription$OrderUpdated instance,
    TRes Function(Variables$Subscription$OrderUpdated) then,
  ) = _CopyWithImpl$Variables$Subscription$OrderUpdated;

  factory CopyWith$Variables$Subscription$OrderUpdated.stub(TRes res) =
      _CopyWithStubImpl$Variables$Subscription$OrderUpdated;

  TRes call({String? id});
}

class _CopyWithImpl$Variables$Subscription$OrderUpdated<TRes>
    implements CopyWith$Variables$Subscription$OrderUpdated<TRes> {
  _CopyWithImpl$Variables$Subscription$OrderUpdated(this._instance, this._then);

  final Variables$Subscription$OrderUpdated _instance;

  final TRes Function(Variables$Subscription$OrderUpdated) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined}) => _then(
    Variables$Subscription$OrderUpdated._({
      ..._instance._$data,
      if (id != _undefined && id != null) 'id': (id as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Subscription$OrderUpdated<TRes>
    implements CopyWith$Variables$Subscription$OrderUpdated<TRes> {
  _CopyWithStubImpl$Variables$Subscription$OrderUpdated(this._res);

  TRes _res;

  call({String? id}) => _res;
}

class Subscription$OrderUpdated {
  Subscription$OrderUpdated({required this.orderUpdated, this.$__typename = 'Subscription'});

  factory Subscription$OrderUpdated.fromJson(Map<String, dynamic> json) {
    final l$orderUpdated = json['orderUpdated'];
    final l$$__typename = json['__typename'];
    return Subscription$OrderUpdated(
      orderUpdated: Fragment$OrderFields.fromJson((l$orderUpdated as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$OrderFields orderUpdated;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$orderUpdated = orderUpdated;
    _resultData['orderUpdated'] = l$orderUpdated.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$orderUpdated = orderUpdated;
    final l$$__typename = $__typename;
    return Object.hashAll([l$orderUpdated, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Subscription$OrderUpdated || runtimeType != other.runtimeType) {
      return false;
    }
    final l$orderUpdated = orderUpdated;
    final lOther$orderUpdated = other.orderUpdated;
    if (l$orderUpdated != lOther$orderUpdated) {
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

extension UtilityExtension$Subscription$OrderUpdated on Subscription$OrderUpdated {
  CopyWith$Subscription$OrderUpdated<Subscription$OrderUpdated> get copyWith =>
      CopyWith$Subscription$OrderUpdated(this, (i) => i);
}

abstract class CopyWith$Subscription$OrderUpdated<TRes> {
  factory CopyWith$Subscription$OrderUpdated(
    Subscription$OrderUpdated instance,
    TRes Function(Subscription$OrderUpdated) then,
  ) = _CopyWithImpl$Subscription$OrderUpdated;

  factory CopyWith$Subscription$OrderUpdated.stub(TRes res) = _CopyWithStubImpl$Subscription$OrderUpdated;

  TRes call({Fragment$OrderFields? orderUpdated, String? $__typename});
  CopyWith$Fragment$OrderFields<TRes> get orderUpdated;
}

class _CopyWithImpl$Subscription$OrderUpdated<TRes> implements CopyWith$Subscription$OrderUpdated<TRes> {
  _CopyWithImpl$Subscription$OrderUpdated(this._instance, this._then);

  final Subscription$OrderUpdated _instance;

  final TRes Function(Subscription$OrderUpdated) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? orderUpdated = _undefined, Object? $__typename = _undefined}) => _then(
    Subscription$OrderUpdated(
      orderUpdated: orderUpdated == _undefined || orderUpdated == null
          ? _instance.orderUpdated
          : (orderUpdated as Fragment$OrderFields),
      $__typename: $__typename == _undefined || $__typename == null ? _instance.$__typename : ($__typename as String),
    ),
  );

  CopyWith$Fragment$OrderFields<TRes> get orderUpdated {
    final local$orderUpdated = _instance.orderUpdated;
    return CopyWith$Fragment$OrderFields(local$orderUpdated, (e) => call(orderUpdated: e));
  }
}

class _CopyWithStubImpl$Subscription$OrderUpdated<TRes> implements CopyWith$Subscription$OrderUpdated<TRes> {
  _CopyWithStubImpl$Subscription$OrderUpdated(this._res);

  TRes _res;

  call({Fragment$OrderFields? orderUpdated, String? $__typename}) => _res;

  CopyWith$Fragment$OrderFields<TRes> get orderUpdated => CopyWith$Fragment$OrderFields.stub(_res);
}

const documentNodeSubscriptionOrderUpdated = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'OrderUpdated'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'orderUpdated'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'OrderFields'),
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
    fragmentDefinitionOrderFields,
    fragmentDefinitionTimeSlotFields,
    fragmentDefinitionPaymentMethodFields,
  ],
);
Subscription$OrderUpdated _parserFn$Subscription$OrderUpdated(Map<String, dynamic> data) =>
    Subscription$OrderUpdated.fromJson(data);

class Options$Subscription$OrderUpdated extends graphql.SubscriptionOptions<Subscription$OrderUpdated> {
  Options$Subscription$OrderUpdated({
    String? operationName,
    required Variables$Subscription$OrderUpdated variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Subscription$OrderUpdated? typedOptimisticResult,
    graphql.Context? context,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionOrderUpdated,
         parserFn: _parserFn$Subscription$OrderUpdated,
       );
}

class WatchOptions$Subscription$OrderUpdated extends graphql.WatchQueryOptions<Subscription$OrderUpdated> {
  WatchOptions$Subscription$OrderUpdated({
    String? operationName,
    required Variables$Subscription$OrderUpdated variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Subscription$OrderUpdated? typedOptimisticResult,
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
         document: documentNodeSubscriptionOrderUpdated,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Subscription$OrderUpdated,
       );
}

class FetchMoreOptions$Subscription$OrderUpdated extends graphql.FetchMoreOptions {
  FetchMoreOptions$Subscription$OrderUpdated({
    required graphql.UpdateQuery updateQuery,
    required Variables$Subscription$OrderUpdated variables,
  }) : super(updateQuery: updateQuery, variables: variables.toJson(), document: documentNodeSubscriptionOrderUpdated);
}

extension ClientExtension$Subscription$OrderUpdated on graphql.GraphQLClient {
  Stream<graphql.QueryResult<Subscription$OrderUpdated>> subscribe$OrderUpdated(
    Options$Subscription$OrderUpdated options,
  ) => this.subscribe(options);

  graphql.ObservableQuery<Subscription$OrderUpdated> watchSubscription$OrderUpdated(
    WatchOptions$Subscription$OrderUpdated options,
  ) => this.watchQuery(options);
}
