import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/entities/edit_job_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class EditJobRepository {
  Future<Either<Failure, bool>> editJob(EditJobEntity editJob);
}
