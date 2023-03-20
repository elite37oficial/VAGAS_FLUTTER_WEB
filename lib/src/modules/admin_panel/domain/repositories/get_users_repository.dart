import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class GetUsersRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers();
}
