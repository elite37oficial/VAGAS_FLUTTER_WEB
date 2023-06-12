import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/domain/entities/admin_get_job_response_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/domain/repositories/admin_get_job_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/infra/datasources/admin_get_job_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/infra/models/admin_get_job_response_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/messages_helper.dart';

class AdminGetJobRepositoryImplementation implements AdminGetJobRepository {
  final AdminGetJobDatasource datasource;

  AdminGetJobRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, AdminGetJobResponseEntity>> adminGetJob(
      int page) async {
    try {
      AdminGetJobResponseModel result = await datasource.adminGetJob(page);
      return Right(result);
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
