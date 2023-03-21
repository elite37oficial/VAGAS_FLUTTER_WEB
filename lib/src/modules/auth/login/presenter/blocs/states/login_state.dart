import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final UserEntity user;

  LoginSuccessState({required this.user});
}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState({required this.message});
}
