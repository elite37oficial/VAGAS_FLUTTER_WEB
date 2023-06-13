import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/domain/entities/admin_get_companies_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class AdminGetCompaniesRepository {
  Future<Either<Failure, AdminGetCompaniesEntity>> adminGetCompanies(int page);
}
