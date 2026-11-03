import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

/// Generates random unique ids (idempotency keys, order ids).
@lazySingleton
class IdGenerator {
  const IdGenerator(this._uuid);

  final Uuid _uuid;

  String call() => _uuid.v4();
}
