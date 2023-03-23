import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/domain/entities/admin_login_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/domain/entities/admin_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/domain/repositories/admin_login_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class AdminLoginUsecase implements Usecase<AdminUserEntity, AdminLoginEntity> {
  final AdminLoginRepository repository;

  AdminLoginUsecase({required this.repository});

  @override
  Future<Either<Failure, AdminUserEntity>> call(
      AdminLoginEntity adminLogin) async {
    return await repository.login(adminLogin);
  }
}
