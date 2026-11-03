import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_session.freezed.dart';

/// A simulated signed-in customer. There is no real authentication.
@freezed
abstract class UserSession with _$UserSession {
  const factory UserSession({required String email}) = _UserSession;
}
