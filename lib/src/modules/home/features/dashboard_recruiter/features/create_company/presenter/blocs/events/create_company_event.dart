import 'package:equatable/equatable.dart';

abstract class CreateCompanyEvent extends Equatable {
  const CreateCompanyEvent();
}

class DoCreateCompanyEvent extends CreateCompanyEvent {
  final String name;
  final String location;
  final String description;

  const DoCreateCompanyEvent({
    required this.name,
    required this.location,
    required this.description,
  });

  @override
  List<Object?> get props => [name, location, description];
}
