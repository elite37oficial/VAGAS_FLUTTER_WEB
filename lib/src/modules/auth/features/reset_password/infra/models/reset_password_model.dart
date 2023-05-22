import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/domain/entities/reset_password_entity.dart';

class ResetPasswordModel extends ResetPasswordEntity {
  const ResetPasswordModel({required super.token, required super.password});

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'token': token,
      'passwordConfirmation': password,
    };
  }

  factory ResetPasswordModel.fromMap(Map<String, dynamic> map) {
    return ResetPasswordModel(
      password: map['password'] ?? '',
      token: map['token'] ?? '',
    );
  }
}
