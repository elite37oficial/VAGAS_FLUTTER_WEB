import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/domain/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class MySelfRepository {
  Future<Either<Failure, UserEntity>> getMySelf(String userId);
}
