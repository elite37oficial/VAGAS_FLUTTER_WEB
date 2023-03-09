import 'package:vagas_flutter_web/src/modules/home/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.userId,
    required super.name,
    required super.lastname,
    required super.enterprise,
    required super.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'lastname': lastname,
      'enterprise': enterprise,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      lastname: map['lastname'] ?? '',
      enterprise: map['enterprise'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
