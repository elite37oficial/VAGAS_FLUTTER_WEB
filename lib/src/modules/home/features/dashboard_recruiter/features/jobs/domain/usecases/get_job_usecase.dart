import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/domain/entities/get_job_response_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/domain/repositories/get_job_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetJobUsecase implements Usecase<GetJobResponseEntity, int> {
  final GetJobRepository repository;

  GetJobUsecase({required this.repository});

  @override
  Future<Either<Failure,GetJobResponseEntity>> call(int page) async {
    return await repository.getJob(page);
  }
}
