import 'package:equatable/equatable.dart';

class ResetPasswordEntity extends Equatable {
  final String password;
  final String token;

  const ResetPasswordEntity({required this.password, required this.token});

  @override
  List<String> get props => [token, password];
}
