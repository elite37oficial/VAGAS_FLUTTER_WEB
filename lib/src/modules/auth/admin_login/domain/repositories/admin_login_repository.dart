import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_login_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_user_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class AdminLoginRepository {
  Future<Either<Failure, AdminUserEntity>> login(AdminLoginEntity adminLogin);
}
