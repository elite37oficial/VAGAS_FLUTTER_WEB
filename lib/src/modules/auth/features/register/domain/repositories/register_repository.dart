import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/entities/register_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class RegisterRepository {
  Future<Either<Failure, bool>> register(
      RegisterEntity registerUser);
}
