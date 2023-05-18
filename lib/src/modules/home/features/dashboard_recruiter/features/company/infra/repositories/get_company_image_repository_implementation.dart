import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/domain/repositories/get_company_image_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/infra/datasources/get_company_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/infra/models/get_company_image_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/messages_helper.dart';

class GetCompanyImageRepositoryImplementation
    implements GetCompanyImageRepository {
  final GetCompanyImageDatasource datasource;

  GetCompanyImageRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, GetCompanyImageModel>> getCompanyImage() async {
    try {
      var result = await datasource.getCompanyImage();

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
