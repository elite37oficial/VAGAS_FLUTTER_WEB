import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/entities/register_user_entity.dart';

class RegisterUserModel extends RegisterUserEntity {
  const RegisterUserModel({
    required super.id,
    required super.profileID,
    required super.name,
    required super.phone,
    required super.email,
    required super.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profileID': profileID,
      'name': name,
      'phone': phone,
      'email': email,
      'status': status,
    };
  }

  factory RegisterUserModel.fromMap(Map<String, dynamic> map) {
    return RegisterUserModel(
      id: map['id'] ?? '',
      profileID: map['profileID'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      status: map['status'] ?? '',
    );
  }
}
