import 'package:equatable/equatable.dart';

abstract class EditCompanyEvent extends Equatable {
  const EditCompanyEvent();
}

class DoEditCompanyEvent extends EditCompanyEvent {
  final String id;
  final String name;
  final String location;
  final String description;
  final String imageType;
  final String image64;

  const DoEditCompanyEvent({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.imageType,
    required this.image64,
  });

  @override
  List<Object?> get props => [id, name, location, description];
}
