import 'package:flutter_test/flutter_test.dart';
import 'package:refreshi_checkout/infrastructure/auth/user_session_model.dart';
import 'package:refreshi_checkout/domain/auth/user_session.dart';

void main() {
  const entity = UserSession(email: 'a@b.co');

  test('maps to and from the entity', () {
    expect(UserSessionModel.fromEntity(entity).toEntity(), entity);
  });

  test('serialises to JSON', () {
    const model = UserSessionModel(email: 'a@b.co');
    expect(model.toJson(), {'email': 'a@b.co'});
    expect(UserSessionModel.fromJson(model.toJson()), model);
  });
}
