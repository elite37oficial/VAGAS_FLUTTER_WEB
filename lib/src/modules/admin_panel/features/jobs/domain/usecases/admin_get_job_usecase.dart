import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/domain/entities/admin_get_job_response_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/domain/repositories/admin_get_job_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class AdminGetJobUsecase implements Usecase<AdminGetJobResponseEntity, int> {
  final AdminGetJobRepository repository;

  AdminGetJobUsecase({required this.repository});

  @override
  Future<Either<Failure, AdminGetJobResponseEntity>> call(int page) async {
    return await repository.adminGetJob(page);
  }
}
