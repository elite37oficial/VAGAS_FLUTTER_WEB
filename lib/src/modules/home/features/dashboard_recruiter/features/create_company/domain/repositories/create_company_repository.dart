import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/domain/entities/create_company_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class CreateCompanyRepository {
  Future<Either<Failure, CreateCompanyEntity>> createCompany(
      CreateCompanyEntity companyData);
}
