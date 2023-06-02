import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';

class GetJobResponseEntity extends Equatable {
  final String actualPage;
  final String totalPages;
  final List<JobEntity> listJobs;

  const GetJobResponseEntity({
    required this.actualPage,
    required this.totalPages,
    required this.listJobs,
  });

  @override
  List<Object?> get props => [listJobs, actualPage, totalPages];
}
