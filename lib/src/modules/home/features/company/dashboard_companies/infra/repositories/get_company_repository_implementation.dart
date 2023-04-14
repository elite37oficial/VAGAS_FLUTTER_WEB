import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/company/dashboard_companies/domain/repositories/get_company_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/company/dashboard_companies/infra/datasources/get_company_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/company/dashboard_companies/infra/models/get_company_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class GetCompanyRepositoryImplementation implements GetCompanyRepository {
  final GetCompanyDatasource datasource;

  GetCompanyRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, List<CompanyEntity>>> getCompany() async {
    try {
      GetCompanyModel result = await datasource.getCompany();
      return Right(result.listCompanies);
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
