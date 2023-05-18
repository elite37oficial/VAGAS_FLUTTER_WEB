import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/domain/entities/get_company_image_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class GetCompanyImageRepository {
  Future<Either<Failure, GetCompanyImageEntity>> getCompanyImage();
}
