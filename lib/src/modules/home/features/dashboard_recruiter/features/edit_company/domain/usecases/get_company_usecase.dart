import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/entities/get_company_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/repositories/get_company_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetCompanyUsecase implements Usecase<GetCompanyEntity, String> {
  final GetCompanyRepository repository;

  const GetCompanyUsecase({required this.repository});

  @override
  Future<Either<Failure, GetCompanyEntity>> call(String id) async {
    return await repository.getCompany(id);
  }
}
