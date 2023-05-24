import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/entities/edit_job_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/repositories/edit_job_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/datasources/edit_job_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/models/edit_job_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/messages_helper.dart';

class EditJobRepositoryImplementation implements EditJobRepository {
  final EditJobDatasource datasource;

  const EditJobRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, bool>> editJob(EditJobEntity params) async {
    try {
      EditJobModel editJobModel = EditJobModel(
        userId: params.userId,
        title: params.title,
        description: params.description,
        companyId: params.companyId,
        email: params.email,
        level: params.level,
        link: params.link,
        phone: params.phone,
        type: params.type,
        city: params.city,
        salary: params.salary,
        companyDescription: params.companyDescription,
        modality: params.modality,
        state: params.state,
        id: params.id,
        status: params.status,
      );

      await datasource.editJob(editJobModel);

      return Right(true);
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
