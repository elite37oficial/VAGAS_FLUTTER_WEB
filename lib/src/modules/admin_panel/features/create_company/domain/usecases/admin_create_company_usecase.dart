import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/entities/admin_create_company_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/repositories/admin_create_company_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/usecases/admin_create_company_abs_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class AdminCreateCompanyUsecase
    implements
        UsecaseAdminCreateCompany<AdminCreateCompanyEntity,
            AdminCreateCompanyEntity> {
  final AdminCreateCompanyRepository repository;

  AdminCreateCompanyUsecase({required this.repository});

  @override
  Future<Either<Failure, AdminCreateCompanyEntity>> call(
      AdminCreateCompanyEntity companyData) async {
    return repository.createCompany(companyData);
  }
}
