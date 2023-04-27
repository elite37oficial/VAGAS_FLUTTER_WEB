import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable {
  final String id;
  final String name;
  final String location;
  final String description;
  final String status;
  final String image64;
  final String state;
  final String city;

  const CompanyEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.status,
    required this.image64,
    required this.state,
    required this.city,
  });

  @override
  List<Object> get props =>
      [id, name, location, description, status, image64, state, city];
}
