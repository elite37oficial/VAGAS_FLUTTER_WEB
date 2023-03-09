import 'package:equatable/equatable.dart';

class RegisterUserEntity extends Equatable {
  final String userId;
  final String name;
  final String email;
  final String password;

  const RegisterUserEntity({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<String> get props => [name, email, password];
}
