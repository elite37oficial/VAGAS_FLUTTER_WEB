import 'package:equatable/equatable.dart';

class CreateCompanyEntity extends Equatable {
  final String name;
  final String location;
  final String description;
  final String status;
  final String state;
  final String city;

  const CreateCompanyEntity({
    required this.name,
    required this.location,
    required this.description,
    required this.status,
    required this.state,
    required this.city,
  });

  @override
  List<Object> get props => [
        name,
        location,
        description,
        status,
        state,
        city,
      ];
}
