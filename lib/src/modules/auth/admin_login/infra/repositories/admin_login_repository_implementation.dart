import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_login_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/repositories/admin_login_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/infra/datasources/admin_login_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/infra/models/admin_login_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class AdminLoginRepositoryImplementation implements AdminLoginRepository {
  final AdminLoginDatasource datasource;

  AdminLoginRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, AdminUserEntity>> login(
      AdminLoginEntity adminLogin) async {
    try {
      AdminLoginModel loginModel = AdminLoginModel(
        email: adminLogin.email,
        password: adminLogin.password,
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
