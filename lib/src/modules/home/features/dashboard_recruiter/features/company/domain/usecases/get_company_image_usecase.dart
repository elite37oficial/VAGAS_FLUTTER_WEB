import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/domain/entities/get_company_image_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/domain/repositories/get_company_image_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetCompanyImageUsecase
    implements Usecase<GetCompanyImageEntity, NoParams> {
  final GetCompanyImageRepository repository;

  GetCompanyImageUsecase({required this.repository});

  @override
  Future<Either<Failure, GetCompanyImageEntity>> call(NoParams params) async {
    return await repository.getCompanyImage();
  }
}
