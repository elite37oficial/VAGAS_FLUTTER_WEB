import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class UsecaseCreateCompany<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}
