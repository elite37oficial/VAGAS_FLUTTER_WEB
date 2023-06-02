import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/entities/edit_get_all_companies_response_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class EditGetAllCompaniesRepository {
  Future<Either<Failure, EditGetAllCompaniesResponseEntity>> getAllCompanies();
}
