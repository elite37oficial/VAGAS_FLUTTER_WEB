import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/get_my_self_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/repositories/get_my_self_repository.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetMySelfUsecase implements Usecase<bool, GetMySelfEntity> {
  final GetMySelfRepository repository;

  const GetMySelfUsecase({required this.repository});
  
  @override
  Future<Either<Failure, bool>> call(GetMySelfEntity getMyselfData) async {
    return await repository.getMySelf(getMyselfData);
  }
}
