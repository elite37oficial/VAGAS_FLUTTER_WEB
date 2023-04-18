import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/job_model.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.userId,
    required super.isAdmin,
    required super.email,
    required super.username,
    required super.createdAt,
    required super.listJobs,
    required super.listEnterprises,
    required super.profession,
    required super.updatedAt,
    required super.about,
    required super.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'isAdmin': isAdmin,
      'email': email,
      'username': username,
      'createdAt': createdAt,
      'listJobs': listJobs,
      'listEnterprises': listEnterprises,
      'profession': profession,
      'updatedAt': updatedAt,
      'about': about,
      'status': status,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      profession: map['profession'] ?? '',
      about: map['about'] ?? '',
      status: map['status'] ?? '',
      listJobs:
          List<JobEntity>.from(map["listJobs"].map((x) => JobModel.fromMap(x))),
      listEnterprises: map['enterprises'] ?? [],
    );
  }
}
