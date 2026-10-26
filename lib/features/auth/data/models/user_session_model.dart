import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_session.dart';

part 'user_session_model.freezed.dart';
part 'user_session_model.g.dart';

@freezed
abstract class UserSessionModel with _$UserSessionModel {
  const UserSessionModel._();

  const factory UserSessionModel({required String email}) = _UserSessionModel;

  factory UserSessionModel.fromJson(Map<String, dynamic> json) => _$UserSessionModelFromJson(json);

  factory UserSessionModel.fromEntity(UserSession session) => UserSessionModel(email: session.email);

  UserSession toEntity() => UserSession(email: email);
}
