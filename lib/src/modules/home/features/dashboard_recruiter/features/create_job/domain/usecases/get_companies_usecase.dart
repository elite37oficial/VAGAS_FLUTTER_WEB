import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/entities/get_companies_response_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/repositories/get_companies_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetCompaniesUsecase
    implements Usecase<GetCompaniesResponseEntity, NoParams> {
  final GetCompaniesRepository repository;

  const GetCompaniesUsecase({required this.repository});

  @override
  Future<Either<Failure, GetCompaniesResponseEntity>> call(
      NoParams params) async {
    return await repository.getCompanies();
  }
}
