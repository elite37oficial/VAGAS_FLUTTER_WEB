import 'package:equatable/equatable.dart';

class AdminUserEntity extends Equatable {
  final String userId;
  final String username;
  final String email;

  const AdminUserEntity({
    required this.userId,
    required this.username,
    required this.email,
  });

  @override
  List<String> get props => [userId, username, email];
}
