import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/domain/entities/change_image_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/infra/models/change_image_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class ChangeImageRepository {
  Future<Either<Failure, ChangeImageModel>> changeImage(
      ChangeImageEntity changeImageData);
}
