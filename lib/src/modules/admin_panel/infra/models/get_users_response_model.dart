import 'dart:convert';

import 'package:vagas_flutter_web/src/modules/admin_panel/domain/entities/job_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/models/job_model.dart';

class GetUsersResponseModel {
  final List<UserModel> listUsers;

  GetUsersResponseModel({required this.listUsers});

  Map<String, dynamic> toMap() {
    return {
      'listUsers': listUsers.map((x) => x.toMap()).toList(),
    };
  }

  factory GetUsersResponseModel.fromMap(Map<String, dynamic> map) {
    return GetUsersResponseModel(
      listUsers: List<UserModel>.from(
          map['listUsers']?.map((x) => UserModel.fromMap(x))),
    );
  }
}

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.createdAt,
    required super.listJobs,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt,
      'listJobs': listJobs,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      email: map["email"] ?? "",
      createdAt: map["createdAt"] ?? "",
      listJobs:
          List<JobEntity>.from(map["listJobs"].map((x) => JobModel.fromMap(x))),
    );
  }
}
