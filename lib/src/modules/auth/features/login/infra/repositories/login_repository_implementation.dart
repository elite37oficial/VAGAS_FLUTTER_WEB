import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/login_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/token_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/repositories/login_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/datasources/login_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/models/login_model.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/models/token_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class LoginRepositoryImplementation implements LoginRepository {
  final LoginDatasource datasource;

  LoginRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, TokenEntity>> login(LoginEntity loginInfo) async {
    try {
      LoginModel loginModel = LoginModel(
        email: loginInfo.email,
        password: loginInfo.password,
      );
      TokenModel result = await datasource.login(loginModel);
      return Right(result);
    } on DioError catch (e) {
      if (e.response!.statusCode == 500) {
        return Left(ServerFailure(e.response!.data["reason"].toString()));
      } else if (e.response!.statusCode == 400) {
        return Left(BadRequestFailure(e.response!.data["reason"].toString()));
      } else {
        return Left(GeneralFailure(e.toString()));
      }
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
