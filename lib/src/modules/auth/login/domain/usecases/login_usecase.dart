import 'package:vagas_flutter_web/src/modules/auth/login/domain/entities/login_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/login/domain/repositories/login_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class LoginUsecase implements Usecase<UserEntity, LoginEntity> {
  final LoginRepository repository;

  LoginUsecase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(LoginEntity loginInfo) async {
    return await repository.login(loginInfo);
  }
}
