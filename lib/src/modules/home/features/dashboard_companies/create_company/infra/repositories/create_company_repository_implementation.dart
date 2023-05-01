import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/domain/entities/create_company_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/domain/repositories/create_company_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/infra/datasources/create_company_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/infra/models/create_company_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';

class CreateCompanyRepositoryImplementation implements CreateCompanyRepository {
  final CreateCompanyDatasource datasource;

  CreateCompanyRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, CompanyEntity>> createCompany(
      CreateCompanyEntity companyData) async {
    try {
      CreateCompanyModel companyModel = CreateCompanyModel(
        name: companyData.name,
        location: companyData.location,
        description: companyData.description,
        state: companyData.state,
        city: companyData.city,
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
