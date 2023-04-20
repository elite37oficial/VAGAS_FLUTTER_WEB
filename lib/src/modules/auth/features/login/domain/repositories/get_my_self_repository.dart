import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/my_self_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class GetMySelfRepository {
  Future<Either<Failure, MySelfEntity>> getMySelf(String id);
}
