import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class GetJobByIdRepository {
  Future<Either<Failure, JobEntity>> getJobById(String jobId);
}
