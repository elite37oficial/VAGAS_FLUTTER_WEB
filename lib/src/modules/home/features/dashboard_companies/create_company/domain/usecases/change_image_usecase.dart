import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/domain/entities/change_image_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/domain/repositories/change_image_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/infra/models/change_image_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class ChangeImageUsecase
    implements Usecase<ChangeImageModel, ChangeImageEntity> {
  final ChangeImageRepository repository;

  ChangeImageUsecase({required this.repository});

  @override
  Future<Either<Failure, ChangeImageModel>> call(
      ChangeImageEntity params) async {
    return await repository.changeImage(params);
  }
}
