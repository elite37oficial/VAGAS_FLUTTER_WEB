import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/entities/edit_company_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/repositories/edit_company_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class EditCompanyUsecase
    implements Usecase<EditCompanyEntity, EditCompanyEntity> {
  final EditCompanyRepository repository;

  EditCompanyUsecase({required this.repository});

  @override
  Future<Either<Failure, EditCompanyEntity>> call(
      EditCompanyEntity editCompanyData) async {
    return repository.editCompany(editCompanyData);
  }
}
