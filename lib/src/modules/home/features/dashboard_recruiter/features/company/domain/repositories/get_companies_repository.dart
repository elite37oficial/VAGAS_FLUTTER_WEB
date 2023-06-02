import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/domain/entities/get_companies_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class GetCompaniesRepository {
  Future<Either<Failure, GetCompaniesEntity>> getCompanies(int page);
}
