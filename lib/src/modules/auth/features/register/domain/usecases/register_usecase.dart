import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/entities/register_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/entities/register_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/repositories/register_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class RegisterUseCase implements Usecase<bool, RegisterEntity> {
  final RegisterRepository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(
      RegisterEntity register) async {
    return await repository.register(register);
  }
}
