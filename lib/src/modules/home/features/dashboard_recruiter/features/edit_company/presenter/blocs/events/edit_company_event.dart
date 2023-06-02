import 'package:equatable/equatable.dart';

abstract class EditCompanyEvent extends Equatable {
  const EditCompanyEvent();
}

class DoEditCompanyEvent extends EditCompanyEvent {
  final String id;
  final String name;
  final String location;
  final String description;

  const DoEditCompanyEvent({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, location, description];
}
