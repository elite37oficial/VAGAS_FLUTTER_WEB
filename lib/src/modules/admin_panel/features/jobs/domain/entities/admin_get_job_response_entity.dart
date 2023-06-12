import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';

class AdminGetJobResponseEntity extends Equatable {
  final String actualPage;
  final String totalPages;
  final List<JobEntity> listJobs;

  const AdminGetJobResponseEntity({
    required this.actualPage,
    required this.totalPages,
    required this.listJobs,
  });

  @override
  List<Object?> get props => [listJobs, actualPage, totalPages];
}
