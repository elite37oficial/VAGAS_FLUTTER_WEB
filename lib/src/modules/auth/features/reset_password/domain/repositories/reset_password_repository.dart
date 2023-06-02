import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/domain/entities/reset_password_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class ResetPasswordRepository {
  Future<Either<Failure, String>> resetPassword(ResetPasswordEntity resetPassword);
}
