import 'package:dartz/dartz.dart';

import 'package:vagas_flutter_web/src/modules/home/features/dashboard_admin/domain/repositories/my_self_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class MySelfUsecase implements Usecase<UserEntity, String> {
  final MySelfRepository repository;

  MySelfUsecase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(String userId) async {
    return await repository.getMySelf(userId);
  }
}
