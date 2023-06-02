import 'package:equatable/equatable.dart';

class GetCompanyEntity extends Equatable {
  final String id;
  final String name;
  final String location;
  final String description;
  final int status;

  const GetCompanyEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.status,
  });

  @override
  List<Object> get props => [
        id,
        name,
        location,
        description,
        status,
      ];
}
