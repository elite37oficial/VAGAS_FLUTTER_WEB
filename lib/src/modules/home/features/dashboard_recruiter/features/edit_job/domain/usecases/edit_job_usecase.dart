import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/entities/edit_job_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/repositories/edit_job_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class EditJobUsecase implements Usecase<bool, EditJobEntity> {
  final EditJobRepository repository;

  const EditJobUsecase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(EditJobEntity editJob) async {
    return await repository.editJob(editJob);
  }
}
