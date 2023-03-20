import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/entities/job_entity.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String createdAt;
  final List<JobEntity> listJobs;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.listJobs,
  });

  @override
  List<Object> get props => [id, name, email, createdAt, listJobs];
}
