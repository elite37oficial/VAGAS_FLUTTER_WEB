import 'package:equatable/equatable.dart';

abstract class AdminCreateCompanyEvent extends Equatable {
  const AdminCreateCompanyEvent();
}

class DoAdminCreateCompanyEvent extends AdminCreateCompanyEvent {
  final String name;
  final String location;
  final String description;

  const DoAdminCreateCompanyEvent({
    required this.name,
    required this.location,
    required this.description,
  });

  @override
  List<Object?> get props => [name, location, description];
}
