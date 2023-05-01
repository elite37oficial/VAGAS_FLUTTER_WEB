import 'package:equatable/equatable.dart';

class CreateCompanyEntity extends Equatable {
  final String name;
  final String location;
  final String description;
  final String? state;
  final String? city;

  const CreateCompanyEntity({
    required this.name,
    required this.location,
    required this.description,
    this.state,
    this.city,
  });

  @override
  List<Object?> get props => [name, description, location];
}
