import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/auth/login/domain/entities/login_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/login/domain/repositories/login_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/login/infra/datasources/login_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/login/infra/models/login_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class LoginRepositoryImplementation implements LoginRepository {
  final LoginDatasource datasource;

  LoginRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, UserEntity>> login(LoginEntity loginInfo) async {
    try {
      LoginModel loginModel = LoginModel(
        email: loginInfo.email,
        password: loginInfo.password,
      );
      var result = await datasource.login(loginModel);
      return Right(result);
    } on InvalidCredentialsException catch (e) {
      return Left(InvalidCredentialsFailure(e.message.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
