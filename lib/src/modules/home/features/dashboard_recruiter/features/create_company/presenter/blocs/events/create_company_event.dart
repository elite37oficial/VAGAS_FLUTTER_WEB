import 'package:equatable/equatable.dart';

abstract class CreateCompanyEvent extends Equatable {
  const CreateCompanyEvent();
}

class DoCreateCompanyEvent extends CreateCompanyEvent {
  final String name;
  final String location;
  final String description;
  final String imageType;
  final String image64;

  const DoCreateCompanyEvent({
    required this.name,
    required this.location,
    required this.description,
    required this.imageType,
    required this.image64,
  });

  @override
  List<Object?> get props => [name, location, description];
}
