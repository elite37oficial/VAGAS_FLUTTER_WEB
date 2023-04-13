import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class GetCompanyRepository {
  Future<Either<Failure, List<CompanyEntity>>> getCompany();
}
