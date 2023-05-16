import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/domain/entities/create_company_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/domain/repositories/create_company_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/domain/usecases/create_company_abs_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class CreateCompanyUsecase
    implements UsecaseCreateCompany<CreateCompanyEntity, CreateCompanyEntity> {
  final CreateCompanyRepository repository;

  CreateCompanyUsecase({required this.repository});

  @override
  Future<Either<Failure, CreateCompanyEntity>> call(
      CreateCompanyEntity companyData) async {
    return repository.createCompany(companyData);
  }
}
