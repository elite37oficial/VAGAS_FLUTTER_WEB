import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/get_my_self_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class GetMySelfRepository {
  Future<Either<Failure, bool>> getMySelf(GetMySelfEntity getMySelfData);
}
