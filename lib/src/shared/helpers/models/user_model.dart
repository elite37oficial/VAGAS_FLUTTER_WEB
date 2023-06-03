import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.profileId,
    required super.isAdmin,
    required super.email,
    required super.name,
    required super.createdDate,
    required super.profession,
    required super.changedDate,
    required super.about,
    required super.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profileId': profileId,
      'isAdmin': isAdmin,
      'email': email,
      'name': name,
      'createdDate': createdDate,
      'profession': profession,
      'changedDate': changedDate,
      'about': about,
      'status': status,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      profileId: map['profileId'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      createdDate: map['createdDate'] ?? '',
      changedDate: map['changedDate'] ?? '',
      profession: map['profession'] ?? '',
      about: map['about'] ?? '',
      status: map['status'] ?? '',
    );
  }
}
