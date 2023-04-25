import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/domain/entities/create_company_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/domain/repositories/create_company_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class CreateCompanyUsecase
    implements Usecase<CompanyEntity, CreateCompanyEntity> {
  final CreateCompanyRepository repository;

  CreateCompanyUsecase({required this.repository});

  @override
  Future<Either<Failure, CompanyEntity>> call(
      CreateCompanyEntity companyData) async {
    return await repository.createCompany(companyData);
  }
}
