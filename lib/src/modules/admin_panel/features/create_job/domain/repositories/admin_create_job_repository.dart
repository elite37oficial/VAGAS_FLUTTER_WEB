import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/entities/admin_create_job_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class AdminCreateJobRepository {
  Future<Either<Failure, bool>> createJob(AdminCreateJobEntity params);
}
