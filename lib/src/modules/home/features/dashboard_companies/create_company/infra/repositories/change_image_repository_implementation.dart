import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/domain/entities/change_image_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/domain/repositories/change_image_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/infra/datasources/change_image_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/infra/models/change_image_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/messages_helper.dart';

class ChangeImageRepositoryImplementation implements ChangeImageRepository {
  final ChangeImageDatasource datasource;

  const ChangeImageRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, ChangeImageModel>> changeImage(
      ChangeImageEntity params) async {
    try {
      ChangeImageModel changeImageModel = ChangeImageModel(
        companyId: params.companyId,
        image64: params.image64,
      );

      var result = await datasource.changeImage(changeImageModel);

      return Right(result);
    } on DioError catch (e) {
      if (e.response!.statusCode == 500) {
        return Left(ServerFailure(MessagesHelper.serverMessage));
      } else if (e.response!.statusCode == 403) {
        return Left(
            InvalidCredentialsFailure(MessagesHelper.credentialsErrorMessage));
      } else if (e.response!.statusCode == 400) {
        return Left(BadRequestFailure(MessagesHelper.badRequestMessage));
      } else {
        return Left(GeneralFailure(e.toString()));
      }
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
