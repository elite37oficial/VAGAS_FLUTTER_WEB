import 'package:equatable/equatable.dart';

class CreateJobEntity extends Equatable {
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
  final int salary;
  final String state;
  final String city;

  const CreateJobEntity({
    required this.title,
    required this.description,
    required this.companyDescription,
    required this.companyId,
    required this.userId,
    required this.modality,
    required this.type,
    required this.level,
    required this.phone,
    required this.email,
    required this.link,
    required this.salary,
    required this.state,
    required this.city,
  });

  @override
  List<Object> get props => [
        userId,
        title,
        description,
        companyDescription,
        companyId,
        type,
        level,
        phone,
        email,
        link,
        modality,
        salary,
        state,
        city,
      ];
}
