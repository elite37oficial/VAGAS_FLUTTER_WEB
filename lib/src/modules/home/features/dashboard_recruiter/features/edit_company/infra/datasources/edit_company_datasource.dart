import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/entities/edit_company_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/models/edit_company_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class EditCompanyDatasource {
  Future<Either<Failure, EditCompanyEntity>> editCompany(
      EditCompanyModel editCompanyData);
}
