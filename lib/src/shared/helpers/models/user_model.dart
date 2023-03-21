import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/job_model.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.userId,
    required super.email,
    required super.username,
    required super.createdAt,
    required super.listJobs,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'username': username,
      'createdAt': createdAt,
      'listJobs': listJobs,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      createdAt: map['createdAt'] ?? '',
      listJobs:
          List<JobEntity>.from(map["listJobs"].map((x) => JobModel.fromMap(x))),
    );
  }
}
