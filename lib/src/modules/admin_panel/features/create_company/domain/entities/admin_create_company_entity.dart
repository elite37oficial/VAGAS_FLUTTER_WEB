import 'package:equatable/equatable.dart';

class AdminCreateCompanyEntity extends Equatable {
  final String? id;
  final String name;
  final String location;
  final String description;
  final String? image64;

  const AdminCreateCompanyEntity({
    this.id,
    required this.name,
    required this.location,
    required this.description,
    this.image64,
  });

  @override
  List<Object?> get props => [name, description, location];
}
