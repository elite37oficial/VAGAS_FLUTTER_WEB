import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';

class UserEntity extends Equatable {
  final String userId;
  final String username;
  final String email;
  final String createdAt;
  final List<JobEntity> listJobs;

  const UserEntity({
    required this.userId,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.listJobs,
  });

  @override
  List<Object> get props => [userId, username, email, createdAt, listJobs];
}
