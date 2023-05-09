import 'package:equatable/equatable.dart';

class CreateCompanyEntity extends Equatable {
  final String name;
  final String location;
  final String description;

  const CreateCompanyEntity({
    required this.name,
    required this.location,
    required this.description,
  });

  @override
  List<Object?> get props => [name, description, location];
}
