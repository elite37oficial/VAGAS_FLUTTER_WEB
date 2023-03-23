

import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/entities/register_user_entity.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final RegisterUserEntity registerUser;

  RegisterSuccessState({required this.registerUser});
}

class RegisterErrorState extends RegisterState {
  final String message;

  RegisterErrorState({required this.message});
}
