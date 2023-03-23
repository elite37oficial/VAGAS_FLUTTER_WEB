import 'package:equatable/equatable.dart';

class AdminUserEntity extends Equatable {
  final String userId;
  final String username;
  final String email;
    final DateTime createdAt;

  const AdminUserEntity({
    required this.userId,
    required this.username,
    required this.email,
    required this.createdAt,
  });

  @override
  List<Object> get props => [userId, username, email, createdAt];
}
