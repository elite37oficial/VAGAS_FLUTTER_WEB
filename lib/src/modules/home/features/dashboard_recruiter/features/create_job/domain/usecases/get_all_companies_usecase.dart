import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/entities/get_all_companies_response_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/repositories/get_all_companies_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetAllCompaniesUsecase
    implements Usecase<GetAllCompaniesResponseEntity, NoParams> {
  final GetAllCompaniesRepository repository;

  const GetAllCompaniesUsecase({required this.repository});

  @override
  Future<Either<Failure, GetAllCompaniesResponseEntity>> call(
      NoParams params) async {
    return await repository.getAllCompanies();
  }
}
