import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/entities/admin_change_image_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/models/admin_change_image_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class AdminChangeImageRepository {
  Future<Either<Failure, AdminChangeImageModel>> changeImage(
      AdminChangeImageEntity changeImageData);
}
