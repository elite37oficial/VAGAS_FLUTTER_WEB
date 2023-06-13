import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/entities/admin_get_users_response_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/repositories/admin_get_users_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class AdminGetUsersUsecase
    implements Usecase<AdminGetUsersResponseEntity, int> {
  final AdminGetUsersRepository repository;

  AdminGetUsersUsecase({required this.repository});

  @override
  Future<Either<Failure, AdminGetUsersResponseEntity>> call(int page) async {
    return await repository.adminGetUsers(page);
  }
}
