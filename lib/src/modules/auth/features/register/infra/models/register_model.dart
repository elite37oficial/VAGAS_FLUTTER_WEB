import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/entities/register_entity.dart';

class RegisterModel extends RegisterEntity {
  const RegisterModel({
    required super.company,
    required super.email,
    required super.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'company': company,
      'email': email,
      'password': password,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      company: map['company'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
