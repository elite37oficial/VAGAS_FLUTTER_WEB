import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/entities/admin_get_all_companies_response_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/repositories/admin_get_all_companies_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class AdminGetAllCompaniesUsecase
    implements Usecase<AdminGetAllCompaniesResponseEntity, NoParams> {
  final AdminGetAllCompaniesRepository repository;

  const AdminGetAllCompaniesUsecase({required this.repository});

  @override
  Future<Either<Failure, AdminGetAllCompaniesResponseEntity>> call(
      NoParams params) async {
    return await repository.getAllCompanies();
  }
}
