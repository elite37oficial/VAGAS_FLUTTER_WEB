import 'package:equatable/equatable.dart';

class CreateCompanyEntity extends Equatable {
  final String name;
  final String location;
  final String description;
  final String status;

  const CreateCompanyEntity({
    required this.name,
    required this.location,
    required this.description,
    required this.status,
  });

  @override
  List<Object> get props => [
        name,
        location,
        description,
        status,
      ];
}
