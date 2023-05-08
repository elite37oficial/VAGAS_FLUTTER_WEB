import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/domain/repositories/reset_password_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/infra/datasources/reset_password_datasource.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/messages_helper.dart';

class ResetPasswordRepositoryImplementation implements ResetPasswordRepository {
  final ResetPasswordDatasource datasource;

  const ResetPasswordRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, String>> resetPassword(String email) async {
    try {
      var result = await datasource.resetPassword(email);

      return Right(result);
    } on DioError catch (e) {
      if (e.response!.statusCode == 500) {
        return Left(ServerFailure(MessagesHelper.serverMessage));
      } else if (e.response!.statusCode == 403) {
        return Left(InvalidCredentialsFailure(
            MessagesHelper.invalidCredentialsMessage));
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
