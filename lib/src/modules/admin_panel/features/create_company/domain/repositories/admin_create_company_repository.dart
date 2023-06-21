import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/entities/admin_create_company_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class AdminCreateCompanyRepository {
  Future<Either<Failure, AdminCreateCompanyEntity>> createCompany(
      AdminCreateCompanyEntity companyData);
}
