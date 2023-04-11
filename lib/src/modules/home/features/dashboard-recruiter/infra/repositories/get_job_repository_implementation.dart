import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/repositories/get_job_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/datasources/get_job_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/models/get_job_responde_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';

class GetJobRepositoryImplementation implements GetJobRepository {
  final GetJobDatasource datasource;

  GetJobRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, List<JobEntity>>> getJob() async {
    try {
      GetJobResponseModel result = await datasource.getJob();
      return Right(result.listJobs);
    } on InvalidCredentialsException catch (e) {
      return Left(InvalidCredentialsFailure(e.message.toString()));
    } on BadRequestException catch (e) {
      return Left(BadRequestFailure(e.message.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
