
import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/domain/entities/get_job_response_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class GetJobRepository {
  Future<Either<Failure, GetJobResponseEntity>> getJob(int page);
}
