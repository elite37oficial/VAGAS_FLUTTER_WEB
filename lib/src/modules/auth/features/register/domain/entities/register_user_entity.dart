import 'package:equatable/equatable.dart';

class RegisterUserEntity extends Equatable {
  final String id;
  final String profileID;
  final String name;
  final String phone;
  final String email;
  final String status;

  const RegisterUserEntity({
    required this.id,
    required this.profileID,
    required this.name,
    required this.phone,
    required this.email,
    required this.status,
  });

  @override
  List<Object> get props => [
        id,
        profileID,
        name,
        phone,
        email,
        status,
      ];
}
