import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/repositories/admin_get_all_companies_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/infra/datasources/admin_get_all_companies_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/infra/models/admin_get_all_companies_response_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/messages_helper.dart';

class AdminGetAllCompaniesRepositoryImplementation
    implements AdminGetAllCompaniesRepository {
  final AdminGetAllCompaniesDatasource datasource;

  const AdminGetAllCompaniesRepositoryImplementation(
      {required this.datasource});

  @override
  Future<Either<Failure, AdminGetAllCompaniesResponseModel>>
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
