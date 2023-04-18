import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final String name;
  final String profileID;
  final String phone;
  final String email;
  final String password;

  const RegisterEntity({
    required this.name,
    required this.phone,
    required this.profileID,
    required this.email,
    required this.password,
  });

  @override
  List<String> get props => [name, profileID, phone, email, password];
}
