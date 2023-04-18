import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/entities/register_entity.dart';

class RegisterModel extends RegisterEntity {
  const RegisterModel({
    required super.name,
    required super.email,
    required super.password,
    required super.profileID,
    required super.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      "profile_id": profileID,
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      name: map['name'] ?? '',
      profileID: map['profile_id'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
