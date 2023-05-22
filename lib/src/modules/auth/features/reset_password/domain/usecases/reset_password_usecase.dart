import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/domain/entities/reset_password_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/domain/repositories/reset_password_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class ResetPasswordUsecase implements Usecase<String, ResetPasswordEntity> {
  final ResetPasswordRepository repository;

  const ResetPasswordUsecase({required this.repository});

  @override
  Future<Either<Failure, String>> call(ResetPasswordEntity resetPassword) async {
    return repository.resetPassword(resetPassword);
  }
}
