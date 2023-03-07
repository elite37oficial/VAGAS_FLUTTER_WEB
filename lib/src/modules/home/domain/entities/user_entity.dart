import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String name;
  final String lastname;
  final String enterprise;
  final String email;

  const UserEntity({
    required this.userId,
    required this.name,
    required this.lastname,
    required this.enterprise,
    required this.email,
  });

  @override
  List<String> get props => [userId, name, lastname, enterprise, email];
}
