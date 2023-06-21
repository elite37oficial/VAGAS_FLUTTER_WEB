import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/entities/admin_create_job_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/repositories/admin_create_job_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class AdminCreateJobUsecase implements Usecase<bool, AdminCreateJobEntity> {
  final AdminCreateJobRepository repository;

  const AdminCreateJobUsecase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(AdminCreateJobEntity params) async {
    return await repository.createJob(params);
  }
}
