import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class Usecase<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
