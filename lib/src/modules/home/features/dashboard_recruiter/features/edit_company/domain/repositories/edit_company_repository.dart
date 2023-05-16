import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/entities/edit_company_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class EditCompanyRepository {
  Future<Either<Failure, EditCompanyEntity>> editCompany(
      EditCompanyEntity editCompanyData);
}
