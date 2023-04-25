import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/my_self_entity.dart';

class MySelfModel extends MySelfEntity {
  const MySelfModel({
    required super.id,
    required super.profileId,
    required super.name,
    required super.phone,
    required super.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profileId': profileId,
      'phone': phone,
    };
  }

  factory MySelfModel.fromMap(Map<String, dynamic> map) {
    return MySelfModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      profileId: map['profileId'] ?? '',
      phone: map['phone'] ?? '',
    );
  }
}
