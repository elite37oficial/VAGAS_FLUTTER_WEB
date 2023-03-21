import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/auth/login/domain/entities/login_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserEntity>> login(LoginEntity loginInfo);
}
