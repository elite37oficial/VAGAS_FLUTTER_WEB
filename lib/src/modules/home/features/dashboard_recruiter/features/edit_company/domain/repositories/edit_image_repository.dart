import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/entities/edit_image_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/models/edit_image_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class EditImageRepository {
  Future<Either<Failure, EditImageModel>> editImage(
      EditImageEntity editImageData);
}
