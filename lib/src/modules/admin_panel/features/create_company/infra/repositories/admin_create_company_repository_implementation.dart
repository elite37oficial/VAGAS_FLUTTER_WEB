import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/entities/admin_create_company_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/repositories/admin_create_company_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/datasources/admin_create_company_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/models/admin_create_company_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class AdminCreateCompanyRepositoryImplementation
    implements AdminCreateCompanyRepository {
  final AdminCreateCompanyDatasource datasource;

  AdminCreateCompanyRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, AdminCreateCompanyEntity>> createCompany(
      AdminCreateCompanyEntity companyData) async {
    try {
      AdminCreateCompanyModel companyModel = AdminCreateCompanyModel(
        id: companyData.id,
        name: companyData.name,
        location: companyData.location,
        description: companyData.description,
      );

      var result = await datasource.createCompany(companyModel);

      return Right(result);
    } on DioError catch (e) {
      if (e.response!.statusCode == 500) {
        return Left(ServerFailure(e.response!.data["reason"].toString()));
      } else if (e.response!.statusCode == 400) {
        return Left(BadRequestFailure(e.response!.data["reason"].toString()));
      } else {
        return Left(GeneralFailure(e.toString()));
      }
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
