import 'package:equatable/equatable.dart';

class GetMySelfEntity extends Equatable {
  final String email;
  final String token;

  const GetMySelfEntity({required this.email, required this.token});

  @override
  List<String> get props => [email, token];
}
