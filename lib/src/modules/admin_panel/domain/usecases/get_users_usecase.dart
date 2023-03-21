import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/repositories/get_users_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetUsersUsecase implements Usecase<List<UserEntity>, NoParams> {
  final GetUsersRepository repository;

  GetUsersUsecase({required this.repository});

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams noParams) async {
    return await repository.getUsers();
  }
}
