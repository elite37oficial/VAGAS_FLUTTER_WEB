import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class ResetPasswordRepository {
  Future<Either<Failure, String>> resetPassword(String email);
}
