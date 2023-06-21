import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/entities/admin_change_image_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/repositories/admin_change_image_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/datasources/admin_change_image_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/models/admin_change_image_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/messages_helper.dart';

class AdminChangeImageRepositoryImplementation
    implements AdminChangeImageRepository {
  final AdminChangeImageDatasource datasource;

  const AdminChangeImageRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, AdminChangeImageModel>> changeImage(
      AdminChangeImageEntity params) async {
    try {
      AdminChangeImageModel changeImageModel = AdminChangeImageModel(
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
