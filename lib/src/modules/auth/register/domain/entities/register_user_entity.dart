import 'package:equatable/equatable.dart';

class RegisterUserEntity extends Equatable {
  final String userId;
  final String username;
  final String company;
  final String email;
  final DateTime createdAt;

  const RegisterUserEntity({
    required this.userId,
    required this.username,
    required this.company,
    required this.email,
    required this.createdAt,
  });

  @override
  List<Object> get props => [userId, username, company, email, createdAt];
}
