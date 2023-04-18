import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/domain/repositories/create_company_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class CreateCompanyUsecase implements Usecase<List<CompanyEntity>, NoParams> {
  final CreateCompanyRepository repository;

  CreateCompanyUsecase({required this.repository});

  @override
  Future<Either<Failure, List<CompanyEntity>>> call(NoParams params) async {
    return await repository.createCompany();
  }
}
