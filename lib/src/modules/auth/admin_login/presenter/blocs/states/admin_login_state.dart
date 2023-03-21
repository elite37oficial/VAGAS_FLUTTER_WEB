import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_user_entity.dart';

abstract class AdminLoginState {}

class AdminLoginInitialState extends AdminLoginState {}

class AdminLoginLoadingState extends AdminLoginState {}

class AdminLoginSuccessState extends AdminLoginState {
  final AdminUserEntity adminUser;

  AdminLoginSuccessState({required this.adminUser});
}

class AdminLoginErrorState extends AdminLoginState {
  final String message;

  AdminLoginErrorState({required this.message});
}
