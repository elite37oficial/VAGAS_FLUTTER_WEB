import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String email;
  final String password;

  const LoginEntity({required this.email, required this.password});

  @override
  List<String> get props => [email, password];
}
