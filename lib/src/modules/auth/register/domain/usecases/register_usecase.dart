import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/entities/register_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/entities/register_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/repositories/register_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class RegisterUsecase implements Usecase<RegisterUserEntity, RegisterEntity> {
  final RegisterRepository repository;

  RegisterUsecase({required this.repository});

  @override
  Future<Either<Failure, RegisterUserEntity>> call(
      RegisterEntity register) async {
    return await repository.register(register);
  }
}