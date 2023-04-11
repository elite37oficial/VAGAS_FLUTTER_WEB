import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';

class UserEntity extends Equatable {
  final String userId;
  final bool isAdmin;
  final String username;
  final String email;
  final String createdAt;
  final String? about;
  final String? profession;
  final String? updatedAt;
  final String? status;
  final List<JobEntity> listJobs;
  final List<String?>? listEnterprises;

  const UserEntity({
    required this.userId,
    required this.isAdmin,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.listJobs,
    this.profession,
    this.updatedAt,
    this.listEnterprises,
    this.about,
    this.status,
  });

  @override
  List<Object?> get props => [
        userId,
        username,
        email,
        createdAt,
        listJobs,
        listEnterprises,
        updatedAt,
        profession,
        about,
        status,
        isAdmin,
      ];
}
