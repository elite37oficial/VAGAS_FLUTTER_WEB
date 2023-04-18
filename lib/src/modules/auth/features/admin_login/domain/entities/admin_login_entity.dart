import 'package:equatable/equatable.dart';

class AdminLoginEntity extends Equatable {
  final String email;
  final String password;

  const AdminLoginEntity({required this.email, required this.password});

  @override
  List<String> get props => [email, password];
}
