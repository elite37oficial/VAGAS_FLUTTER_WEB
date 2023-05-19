import 'package:equatable/equatable.dart';

class EditCompanyEntity extends Equatable {
  final String? id;
  final String name;
  final String location;
  final String description;
  final String? image64;

  const EditCompanyEntity({
    this.id,
    required this.name,
    required this.location,
    required this.description,
    this.image64,
  });

  @override
  List<Object?> get props => [id, name, location, description];
}
