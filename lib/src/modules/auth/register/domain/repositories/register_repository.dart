import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/entities/register_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/entities/register_user_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class RegisterRepository {
  Future<Either<Failure, RegisterUserEntity>> register(
      RegisterEntity registerUser);
}
