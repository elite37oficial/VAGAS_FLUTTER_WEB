import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/entities/get_all_companies_response_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class GetAllCompaniesRepository {
  Future<Either<Failure, GetAllCompaniesResponseEntity>> getAllCompanies();
}
