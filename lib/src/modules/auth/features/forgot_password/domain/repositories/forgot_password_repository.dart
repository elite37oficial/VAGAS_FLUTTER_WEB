import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class ForgotPasswordRepository {
  Future<Either<Failure, String>> forgotPassword(String email);
}
