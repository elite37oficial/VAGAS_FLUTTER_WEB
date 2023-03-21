import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final String company;
  final String email;
  final String password;

  const RegisterEntity(
      {required this.company, required this.email, required this.password});

  @override
  List<String> get props => [company, email, password];
}
