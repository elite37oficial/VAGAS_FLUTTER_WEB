import 'package:equatable/equatable.dart';

abstract class CreateCompanyEvent extends Equatable {
  const CreateCompanyEvent();
}

class DoCreateCompanyEvent extends CreateCompanyEvent {
  final String name;
  final String location;
  final String description;
  final String? state;
  final String? city;

  const DoCreateCompanyEvent({
    required this.name,
    required this.location,
    required this.description,
    this.state,
    this.city,
  });

  @override
  List<Object?> get props => [name, location, description];
}
