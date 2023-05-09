import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/domain/repositories/get_job_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/infra/datasources/get_job_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/infra/models/get_job_responde_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/messages_helper.dart';

class GetJobRepositoryImplementation implements GetJobRepository {
  final GetJobDatasource datasource;

  GetJobRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, List<JobEntity>>> getJob(int page) async {
    try {
      GetJobResponseModel result = await datasource.getJob(page);
      return Right(result.listJobs);
    } on DioError catch (e) {
      if (e.response!.statusCode == 500) {
        return Left(ServerFailure(MessagesHelper.serverMessage));
      } else if (e.response!.statusCode == 403) {
        return Left(
            InvalidCredentialsFailure(MessagesHelper.credentialsErrorMessage));
      } else if (e.response!.statusCode == 400) {
        return Left(BadRequestFailure(MessagesHelper.badRequestMessage));
      } else {
        return Left(GeneralFailure(e.toString()));
      }
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
