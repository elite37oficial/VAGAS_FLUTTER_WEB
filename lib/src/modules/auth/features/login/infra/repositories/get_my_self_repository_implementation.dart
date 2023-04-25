import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/my_self_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/repositories/get_my_self_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/datasources/get_my_self_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/models/my_self_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/messages_helper.dart';

class GetMySelfRepositoryImplementation implements GetMySelfRepository {
  final GetMySelfDatasource datasource;

  const GetMySelfRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, MySelfEntity>> getMySelf(String id) async {
    try {
      MySelfModel result = await datasource.getMySelf(id);
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
