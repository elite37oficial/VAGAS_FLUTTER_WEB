enum UserRole { recrutador, admin }

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final UserRole userRole;

  LoginSuccessState({required this.userRole});
}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState({required this.message});
}
