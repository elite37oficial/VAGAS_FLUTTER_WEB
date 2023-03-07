import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class GeneralFailure extends Failure {
  final String message;

  GeneralFailure(this.message);
  @override
  List<Object> get props => [message];
}

class InvalidCredentialsFailure extends Failure {
  final String message;

  InvalidCredentialsFailure(this.message);

  @override
  List<Object> get props => [message];
}

class BadRequestFailure extends Failure {
  final String message;

  BadRequestFailure(this.message);

  @override
  List<Object> get props => [message];
}
class ServerFailure extends Failure {
  final String message;

  ServerFailure(this.message);

  @override
  List<Object> get props => [message];
}
