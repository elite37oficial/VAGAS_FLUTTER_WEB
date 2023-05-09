import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class ForgotPasswordUsecase implements Usecase<String, String> {
  final ForgotPasswordRepository repository;

  const ForgotPasswordUsecase({required this.repository});
  @override
  Future<Either<Failure, String>> call(String email) async {
    return repository.forgotPassword(email);
  }
}
