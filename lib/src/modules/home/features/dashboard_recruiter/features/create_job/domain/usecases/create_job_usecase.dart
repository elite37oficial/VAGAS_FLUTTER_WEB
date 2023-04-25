import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/entities/create_job_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/repositories/create_job_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/models/create_job_response_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class CreateJobUsecase implements Usecase<CreateJobResponseModel, CreateJobEntity> {
  final CreateJobRepository repository;

  const CreateJobUsecase({required this.repository});

  @override
  Future<Either<Failure, CreateJobResponseModel>> call(CreateJobEntity params) async {
    return await repository.createJob(params);
  }
}
