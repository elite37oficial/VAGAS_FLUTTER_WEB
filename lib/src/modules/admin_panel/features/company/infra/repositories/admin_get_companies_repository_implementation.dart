import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/domain/entities/admin_get_companies_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/domain/repositories/admin_get_companies_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/infra/datasources/admin_get_companies_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/infra/models/admin_get_companies_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/messages_helper.dart';

class AdminGetCompaniesRepositoryImplementation
    implements AdminGetCompaniesRepository {
  final AdminGetCompaniesDatasource datasource;

  AdminGetCompaniesRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, AdminGetCompaniesEntity>> adminGetCompanies(
      int page) async {
    try {
      AdminGetCompaniesModel result = await datasource.adminGetCompanies();

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
