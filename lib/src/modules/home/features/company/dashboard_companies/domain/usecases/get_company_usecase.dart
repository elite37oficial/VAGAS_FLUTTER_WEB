import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/company/dashboard_companies/domain/repositories/get_company_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetCompanyUsecase implements Usecase<List<CompanyEntity>, NoParams> {
  final GetCompanyRepository repository;

  GetCompanyUsecase({required this.repository});

  @override
  Future<Either<Failure, List<CompanyEntity>>> call(NoParams noParams) async {
    return await repository.getCompany();
  }
}
