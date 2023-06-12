import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/domain/entities/admin_get_job_response_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class AdminGetJobRepository {
  Future<Either<Failure, AdminGetJobResponseEntity>> adminGetJob(int page);
}
