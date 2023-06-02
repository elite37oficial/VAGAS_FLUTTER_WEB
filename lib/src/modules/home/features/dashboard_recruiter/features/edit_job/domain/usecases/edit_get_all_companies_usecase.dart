import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/entities/edit_get_all_companies_response_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/repositories/edit_get_all_companies_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class EditGetAllCompaniesUsecase
    implements Usecase<EditGetAllCompaniesResponseEntity, NoParams> {
  final EditGetAllCompaniesRepository repository;

  const EditGetAllCompaniesUsecase({required this.repository});

  @override
  Future<Either<Failure, EditGetAllCompaniesResponseEntity>> call(
      NoParams params) async {
    return await repository.getAllCompanies();
  }
}
