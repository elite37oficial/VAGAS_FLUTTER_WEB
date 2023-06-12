import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/entities/get_users_response_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class GetUsersRepository {
  Future<Either<Failure, GetUsersResponseEntity>> adminGetUsers(int page);
}
