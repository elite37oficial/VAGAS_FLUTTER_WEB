import 'package:vagas_flutter_web/src/modules/auth/register/domain/entities/register_user_entity.dart';

class RegisterUserModel extends RegisterUserEntity {
  const RegisterUserModel({
    required super.userId,
    required super.email,
    required super.name,
    required super.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'password': password,
    };
  }

  factory RegisterUserModel.fromMap(Map<String, dynamic> map) {
    return RegisterUserModel(
      userId: map['userId'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
