import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/login_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/token_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/repositories/login_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class LoginUsecase implements Usecase<TokenEntity, LoginEntity> {
  final LoginRepository repository;

  LoginUsecase({required this.repository});

  @override
  Future<Either<Failure, TokenEntity>> call(LoginEntity loginInfo) async {
    return await repository.login(loginInfo);
  }
}
