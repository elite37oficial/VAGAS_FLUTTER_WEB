import 'package:vagas_flutter_web/src/modules/auth/register/domain/entities/register_user_entity.dart';

class RegisterUserModel extends RegisterUserEntity {
  const RegisterUserModel({
    required super.userId,
    required super.company,
    required super.username,
    required super.email,
    required super.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'company': company,
      'username': username,
      'email': email,
      'createdAt': createdAt,
    };
  }

  factory RegisterUserModel.fromMap(Map<String, dynamic> map) {
    return RegisterUserModel(
      userId: map['userId'] ?? '',
      company: map['company'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }
}
