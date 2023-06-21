import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/entities/admin_change_image_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/repositories/admin_change_image_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/models/admin_change_image_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class AdminChangeImageUsecase
    implements Usecase<AdminChangeImageModel, AdminChangeImageEntity> {
  final AdminChangeImageRepository repository;

  AdminChangeImageUsecase({required this.repository});

  @override
  Future<Either<Failure, AdminChangeImageModel>> call(
      AdminChangeImageEntity params) async {
    return await repository.changeImage(params);
  }
}
