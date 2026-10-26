class Input$CreateOrderInput {
  factory Input$CreateOrderInput({
    required String idempotencyKey,
    required List<String> serviceIds,
    required String slotId,
    required String paymentMethodId,
  }) => Input$CreateOrderInput._({
    r'idempotencyKey': idempotencyKey,
    r'serviceIds': serviceIds,
    r'slotId': slotId,
    r'paymentMethodId': paymentMethodId,
  });

  Input$CreateOrderInput._(this._$data);

  factory Input$CreateOrderInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$idempotencyKey = data['idempotencyKey'];
    result$data['idempotencyKey'] = (l$idempotencyKey as String);
    final l$serviceIds = data['serviceIds'];
    result$data['serviceIds'] = (l$serviceIds as List<dynamic>).map((e) => (e as String)).toList();
    final l$slotId = data['slotId'];
    result$data['slotId'] = (l$slotId as String);
    final l$paymentMethodId = data['paymentMethodId'];
    result$data['paymentMethodId'] = (l$paymentMethodId as String);
    return Input$CreateOrderInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get idempotencyKey => (_$data['idempotencyKey'] as String);

  List<String> get serviceIds => (_$data['serviceIds'] as List<String>);

  String get slotId => (_$data['slotId'] as String);

  String get paymentMethodId => (_$data['paymentMethodId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$idempotencyKey = idempotencyKey;
    result$data['idempotencyKey'] = l$idempotencyKey;
    final l$serviceIds = serviceIds;
    result$data['serviceIds'] = l$serviceIds.map((e) => e).toList();
    final l$slotId = slotId;
    result$data['slotId'] = l$slotId;
    final l$paymentMethodId = paymentMethodId;
    result$data['paymentMethodId'] = l$paymentMethodId;
    return result$data;
  }

  CopyWith$Input$CreateOrderInput<Input$CreateOrderInput> get copyWith =>
      CopyWith$Input$CreateOrderInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$CreateOrderInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$idempotencyKey = idempotencyKey;
    final lOther$idempotencyKey = other.idempotencyKey;
    if (l$idempotencyKey != lOther$idempotencyKey) {
      return false;
    }
    final l$serviceIds = serviceIds;
    final lOther$serviceIds = other.serviceIds;
    if (l$serviceIds.length != lOther$serviceIds.length) {
      return false;
    }
    for (int i = 0; i < l$serviceIds.length; i++) {
      final l$serviceIds$entry = l$serviceIds[i];
      final lOther$serviceIds$entry = lOther$serviceIds[i];
      if (l$serviceIds$entry != lOther$serviceIds$entry) {
        return false;
      }
    }
    final l$slotId = slotId;
    final lOther$slotId = other.slotId;
    if (l$slotId != lOther$slotId) {
      return false;
    }
    final l$paymentMethodId = paymentMethodId;
    final lOther$paymentMethodId = other.paymentMethodId;
    if (l$paymentMethodId != lOther$paymentMethodId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$idempotencyKey = idempotencyKey;
    final l$serviceIds = serviceIds;
    final l$slotId = slotId;
    final l$paymentMethodId = paymentMethodId;
    return Object.hashAll([l$idempotencyKey, Object.hashAll(l$serviceIds.map((v) => v)), l$slotId, l$paymentMethodId]);
  }
}

abstract class CopyWith$Input$CreateOrderInput<TRes> {
  factory CopyWith$Input$CreateOrderInput(Input$CreateOrderInput instance, TRes Function(Input$CreateOrderInput) then) =
      _CopyWithImpl$Input$CreateOrderInput;

  factory CopyWith$Input$CreateOrderInput.stub(TRes res) = _CopyWithStubImpl$Input$CreateOrderInput;

  TRes call({String? idempotencyKey, List<String>? serviceIds, String? slotId, String? paymentMethodId});
}

class _CopyWithImpl$Input$CreateOrderInput<TRes> implements CopyWith$Input$CreateOrderInput<TRes> {
  _CopyWithImpl$Input$CreateOrderInput(this._instance, this._then);

  final Input$CreateOrderInput _instance;

  final TRes Function(Input$CreateOrderInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? idempotencyKey = _undefined,
    Object? serviceIds = _undefined,
    Object? slotId = _undefined,
    Object? paymentMethodId = _undefined,
  }) => _then(
    Input$CreateOrderInput._({
      ..._instance._$data,
      if (idempotencyKey != _undefined && idempotencyKey != null) 'idempotencyKey': (idempotencyKey as String),
      if (serviceIds != _undefined && serviceIds != null) 'serviceIds': (serviceIds as List<String>),
      if (slotId != _undefined && slotId != null) 'slotId': (slotId as String),
      if (paymentMethodId != _undefined && paymentMethodId != null) 'paymentMethodId': (paymentMethodId as String),
    }),
  );
}

class _CopyWithStubImpl$Input$CreateOrderInput<TRes> implements CopyWith$Input$CreateOrderInput<TRes> {
  _CopyWithStubImpl$Input$CreateOrderInput(this._res);

  TRes _res;

  call({String? idempotencyKey, List<String>? serviceIds, String? slotId, String? paymentMethodId}) => _res;
}

enum Enum$OrderStatus {
  AWAITING_HOLD,
  CONFIRMED,
  PAYMENT_FAILED,
  $unknown;

  factory Enum$OrderStatus.fromJson(String value) => fromJson$Enum$OrderStatus(value);

  String toJson() => toJson$Enum$OrderStatus(this);
}

String toJson$Enum$OrderStatus(Enum$OrderStatus e) {
  switch (e) {
    case Enum$OrderStatus.AWAITING_HOLD:
      return r'AWAITING_HOLD';
    case Enum$OrderStatus.CONFIRMED:
      return r'CONFIRMED';
    case Enum$OrderStatus.PAYMENT_FAILED:
      return r'PAYMENT_FAILED';
    case Enum$OrderStatus.$unknown:
      return r'$unknown';
  }
}

Enum$OrderStatus fromJson$Enum$OrderStatus(String value) {
  switch (value) {
    case r'AWAITING_HOLD':
      return Enum$OrderStatus.AWAITING_HOLD;
    case r'CONFIRMED':
      return Enum$OrderStatus.CONFIRMED;
    case r'PAYMENT_FAILED':
      return Enum$OrderStatus.PAYMENT_FAILED;
    default:
      return Enum$OrderStatus.$unknown;
  }
}

enum Enum$HoldStatus {
  PENDING,
  PLACED,
  FAILED,
  $unknown;

  factory Enum$HoldStatus.fromJson(String value) => fromJson$Enum$HoldStatus(value);

  String toJson() => toJson$Enum$HoldStatus(this);
}

String toJson$Enum$HoldStatus(Enum$HoldStatus e) {
  switch (e) {
    case Enum$HoldStatus.PENDING:
      return r'PENDING';
    case Enum$HoldStatus.PLACED:
      return r'PLACED';
    case Enum$HoldStatus.FAILED:
      return r'FAILED';
    case Enum$HoldStatus.$unknown:
      return r'$unknown';
  }
}

Enum$HoldStatus fromJson$Enum$HoldStatus(String value) {
  switch (value) {
    case r'PENDING':
      return Enum$HoldStatus.PENDING;
    case r'PLACED':
      return Enum$HoldStatus.PLACED;
    case r'FAILED':
      return Enum$HoldStatus.FAILED;
    default:
      return Enum$HoldStatus.$unknown;
  }
}

enum Enum$TimelineEventType {
  ORDER_CREATED,
  HOLD_REQUESTED,
  HOLD_PLACED,
  HOLD_FAILED,
  $unknown;

  factory Enum$TimelineEventType.fromJson(String value) => fromJson$Enum$TimelineEventType(value);

  String toJson() => toJson$Enum$TimelineEventType(this);
}

String toJson$Enum$TimelineEventType(Enum$TimelineEventType e) {
  switch (e) {
    case Enum$TimelineEventType.ORDER_CREATED:
      return r'ORDER_CREATED';
    case Enum$TimelineEventType.HOLD_REQUESTED:
      return r'HOLD_REQUESTED';
    case Enum$TimelineEventType.HOLD_PLACED:
      return r'HOLD_PLACED';
    case Enum$TimelineEventType.HOLD_FAILED:
      return r'HOLD_FAILED';
    case Enum$TimelineEventType.$unknown:
      return r'$unknown';
  }
}

Enum$TimelineEventType fromJson$Enum$TimelineEventType(String value) {
  switch (value) {
    case r'ORDER_CREATED':
      return Enum$TimelineEventType.ORDER_CREATED;
    case r'HOLD_REQUESTED':
      return Enum$TimelineEventType.HOLD_REQUESTED;
    case r'HOLD_PLACED':
      return Enum$TimelineEventType.HOLD_PLACED;
    case r'HOLD_FAILED':
      return Enum$TimelineEventType.HOLD_FAILED;
    default:
      return Enum$TimelineEventType.$unknown;
  }
}

enum Enum$__TypeKind {
  SCALAR,
  OBJECT,
  INTERFACE,
  UNION,
  ENUM,
  INPUT_OBJECT,
  LIST,
  NON_NULL,
  $unknown;

  factory Enum$__TypeKind.fromJson(String value) => fromJson$Enum$__TypeKind(value);

  String toJson() => toJson$Enum$__TypeKind(this);
}

String toJson$Enum$__TypeKind(Enum$__TypeKind e) {
  switch (e) {
    case Enum$__TypeKind.SCALAR:
      return r'SCALAR';
    case Enum$__TypeKind.OBJECT:
      return r'OBJECT';
    case Enum$__TypeKind.INTERFACE:
      return r'INTERFACE';
    case Enum$__TypeKind.UNION:
      return r'UNION';
    case Enum$__TypeKind.ENUM:
      return r'ENUM';
    case Enum$__TypeKind.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__TypeKind.LIST:
      return r'LIST';
    case Enum$__TypeKind.NON_NULL:
      return r'NON_NULL';
    case Enum$__TypeKind.$unknown:
      return r'$unknown';
  }
}

Enum$__TypeKind fromJson$Enum$__TypeKind(String value) {
  switch (value) {
    case r'SCALAR':
      return Enum$__TypeKind.SCALAR;
    case r'OBJECT':
      return Enum$__TypeKind.OBJECT;
    case r'INTERFACE':
      return Enum$__TypeKind.INTERFACE;
    case r'UNION':
      return Enum$__TypeKind.UNION;
    case r'ENUM':
      return Enum$__TypeKind.ENUM;
    case r'INPUT_OBJECT':
      return Enum$__TypeKind.INPUT_OBJECT;
    case r'LIST':
      return Enum$__TypeKind.LIST;
    case r'NON_NULL':
      return Enum$__TypeKind.NON_NULL;
    default:
      return Enum$__TypeKind.$unknown;
  }
}

enum Enum$__DirectiveLocation {
  QUERY,
  MUTATION,
  SUBSCRIPTION,
  FIELD,
  FRAGMENT_DEFINITION,
  FRAGMENT_SPREAD,
  INLINE_FRAGMENT,
  VARIABLE_DEFINITION,
  SCHEMA,
  SCALAR,
  OBJECT,
  FIELD_DEFINITION,
  ARGUMENT_DEFINITION,
  INTERFACE,
  UNION,
  ENUM,
  ENUM_VALUE,
  INPUT_OBJECT,
  INPUT_FIELD_DEFINITION,
  $unknown;

  factory Enum$__DirectiveLocation.fromJson(String value) => fromJson$Enum$__DirectiveLocation(value);

  String toJson() => toJson$Enum$__DirectiveLocation(this);
}

String toJson$Enum$__DirectiveLocation(Enum$__DirectiveLocation e) {
  switch (e) {
    case Enum$__DirectiveLocation.QUERY:
      return r'QUERY';
    case Enum$__DirectiveLocation.MUTATION:
      return r'MUTATION';
    case Enum$__DirectiveLocation.SUBSCRIPTION:
      return r'SUBSCRIPTION';
    case Enum$__DirectiveLocation.FIELD:
      return r'FIELD';
    case Enum$__DirectiveLocation.FRAGMENT_DEFINITION:
      return r'FRAGMENT_DEFINITION';
    case Enum$__DirectiveLocation.FRAGMENT_SPREAD:
      return r'FRAGMENT_SPREAD';
    case Enum$__DirectiveLocation.INLINE_FRAGMENT:
      return r'INLINE_FRAGMENT';
    case Enum$__DirectiveLocation.VARIABLE_DEFINITION:
      return r'VARIABLE_DEFINITION';
    case Enum$__DirectiveLocation.SCHEMA:
      return r'SCHEMA';
    case Enum$__DirectiveLocation.SCALAR:
      return r'SCALAR';
    case Enum$__DirectiveLocation.OBJECT:
      return r'OBJECT';
    case Enum$__DirectiveLocation.FIELD_DEFINITION:
      return r'FIELD_DEFINITION';
    case Enum$__DirectiveLocation.ARGUMENT_DEFINITION:
      return r'ARGUMENT_DEFINITION';
    case Enum$__DirectiveLocation.INTERFACE:
      return r'INTERFACE';
    case Enum$__DirectiveLocation.UNION:
      return r'UNION';
    case Enum$__DirectiveLocation.ENUM:
      return r'ENUM';
    case Enum$__DirectiveLocation.ENUM_VALUE:
      return r'ENUM_VALUE';
    case Enum$__DirectiveLocation.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION:
      return r'INPUT_FIELD_DEFINITION';
    case Enum$__DirectiveLocation.$unknown:
      return r'$unknown';
  }
}

Enum$__DirectiveLocation fromJson$Enum$__DirectiveLocation(String value) {
  switch (value) {
    case r'QUERY':
      return Enum$__DirectiveLocation.QUERY;
    case r'MUTATION':
      return Enum$__DirectiveLocation.MUTATION;
    case r'SUBSCRIPTION':
      return Enum$__DirectiveLocation.SUBSCRIPTION;
    case r'FIELD':
      return Enum$__DirectiveLocation.FIELD;
    case r'FRAGMENT_DEFINITION':
      return Enum$__DirectiveLocation.FRAGMENT_DEFINITION;
    case r'FRAGMENT_SPREAD':
      return Enum$__DirectiveLocation.FRAGMENT_SPREAD;
    case r'INLINE_FRAGMENT':
      return Enum$__DirectiveLocation.INLINE_FRAGMENT;
    case r'VARIABLE_DEFINITION':
      return Enum$__DirectiveLocation.VARIABLE_DEFINITION;
    case r'SCHEMA':
      return Enum$__DirectiveLocation.SCHEMA;
    case r'SCALAR':
      return Enum$__DirectiveLocation.SCALAR;
    case r'OBJECT':
      return Enum$__DirectiveLocation.OBJECT;
    case r'FIELD_DEFINITION':
      return Enum$__DirectiveLocation.FIELD_DEFINITION;
    case r'ARGUMENT_DEFINITION':
      return Enum$__DirectiveLocation.ARGUMENT_DEFINITION;
    case r'INTERFACE':
      return Enum$__DirectiveLocation.INTERFACE;
    case r'UNION':
      return Enum$__DirectiveLocation.UNION;
    case r'ENUM':
      return Enum$__DirectiveLocation.ENUM;
    case r'ENUM_VALUE':
      return Enum$__DirectiveLocation.ENUM_VALUE;
    case r'INPUT_OBJECT':
      return Enum$__DirectiveLocation.INPUT_OBJECT;
    case r'INPUT_FIELD_DEFINITION':
      return Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION;
    default:
      return Enum$__DirectiveLocation.$unknown;
  }
}

const possibleTypesMap = <String, Set<String>>{};
