import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/repositories/edit_get_all_companies_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/datasources/edit_get_all_companies_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/models/edit_get_all_companies_response_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/messages_helper.dart';

class EditGetAllCompaniesRepositoryImplementation
    implements EditGetAllCompaniesRepository {
  final EditGetAllCompaniesDatasource datasource;

  const EditGetAllCompaniesRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, EditGetAllCompaniesResponseModel>>
      getAllCompanies() async {
    try {
      var result = await datasource.getAllCompanies();

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
