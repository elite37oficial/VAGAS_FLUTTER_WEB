import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/repositories/get_job_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetJobUsecase implements Usecase<List<JobEntity>, NoParams> {
  final GetJobRepository repository;

  GetJobUsecase({required this.repository});

  @override
  Future<Either<Failure, List<JobEntity>>> call(NoParams noParams) async {
    return await repository.getJob();
  }
}
