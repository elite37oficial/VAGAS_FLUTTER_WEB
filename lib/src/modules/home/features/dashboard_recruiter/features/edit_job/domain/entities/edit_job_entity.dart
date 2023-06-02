import 'package:equatable/equatable.dart';

class EditJobEntity extends Equatable {
  final String id;
  final String status;
  final String title;
  final String description;
  final String companyDescription;
  final String companyId;
  final String type;
  final String userId;
  final String level;
  final String phone;
  final String email;
  final String modality;
  final String link;
  final double salary;
  final String state;
  final String city;

  const EditJobEntity({
    required this.id,
    required this.status,
    required this.title,
    required this.description,
    required this.companyDescription,
    required this.companyId,
    required this.type,
    required this.userId,
    required this.level,
    required this.phone,
    required this.email,
    required this.modality,
    required this.link,
    required this.salary,
    required this.state,
    required this.city,
  });

  @override
  List<Object> get props => [
        userId,
        type,
        email,
        id,
        city,
        companyDescription,
        companyId,
        description,
        level,
        link,
        modality,
        phone,
        state,
        salary,
        status,
        title,
      ];
}
