import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/domain/entities/admin_get_companies_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/domain/repositories/admin_get_companies_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class AdminGetCompaniesUsecase
    implements Usecase<AdminGetCompaniesEntity, int> {
  final AdminGetCompaniesRepository repository;

  AdminGetCompaniesUsecase({required this.repository});

  @override
  Future<Either<Failure, AdminGetCompaniesEntity>> call(int page) async {
    return await repository.adminGetCompanies(page);
  }
}
