import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/repositories/get_job_by_id_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetJobByIdUsecase implements Usecase<JobEntity, String> {
  final GetJobByIdRepository repository;

  const GetJobByIdUsecase({required this.repository});

  @override
  Future<Either<Failure, JobEntity>> call(String jobId) async {
    return await repository.getJobById(jobId);
  }
}
