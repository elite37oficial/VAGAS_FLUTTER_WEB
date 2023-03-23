import 'package:equatable/equatable.dart';

abstract class AdminLoginEvent extends Equatable {
  const AdminLoginEvent();
}

class LoginEvent extends AdminLoginEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
