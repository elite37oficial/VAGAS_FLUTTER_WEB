import 'package:equatable/equatable.dart';

class MySelfEntity extends Equatable {
  final String id;
  final String profileId;
  final String name;
  final String phone;
  final String email;

  const MySelfEntity({
    required this.id,
    required this.profileId,
    required this.name,
    required this.phone,
    required this.email,
  });

  @override
  List<String> get props => [id, email, name, phone, profileId];
}
