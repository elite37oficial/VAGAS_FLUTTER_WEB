import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/domain/entities/get_companies_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/domain/repositories/get_companies_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetCompaniesUsecase implements Usecase<GetCompaniesEntity, NoParams> {
  final GetCompaniesRepository repository;

  GetCompaniesUsecase({required this.repository});

  @override
  Future<Either<Failure, GetCompaniesEntity>> call(NoParams params) async {
    return await repository.getCompanies();
  }
}
