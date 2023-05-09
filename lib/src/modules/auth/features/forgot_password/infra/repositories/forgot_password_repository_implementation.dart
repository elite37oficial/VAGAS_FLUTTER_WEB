import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/infra/datasources/forgot_password_datasource.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/messages_helper.dart';

class ForgotPasswordRepositoryImplementation
    implements ForgotPasswordRepository {
  final ForgotPasswordDatasource datasource;

  const ForgotPasswordRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    try {
      var result = await datasource.forgotPassword(email);

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
