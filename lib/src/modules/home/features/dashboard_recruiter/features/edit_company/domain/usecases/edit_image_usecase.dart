import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/entities/edit_image_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/repositories/edit_image_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/models/edit_image_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class EditImageUsecase implements Usecase<EditImageModel, EditImageEntity> {
  final EditImageRepository repository;

  EditImageUsecase({required this.repository});

  @override
  Future<Either<Failure, EditImageModel>> call(EditImageEntity params) async {
    return await repository.editImage(params);
  }
}
