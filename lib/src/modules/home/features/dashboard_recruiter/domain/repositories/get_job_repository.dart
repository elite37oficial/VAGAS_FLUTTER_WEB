
import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class GetJobRepository {
  Future<Either<Failure, List<JobEntity>>> getJob();
}
