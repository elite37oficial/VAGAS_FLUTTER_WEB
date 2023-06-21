import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/entities/admin_get_all_companies_response_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class AdminGetAllCompaniesRepository {
  Future<Either<Failure, AdminGetAllCompaniesResponseEntity>> getAllCompanies();
}
