import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String companyId;
  final String companyDescription;
  final String state;
  final String city;
  final String modality;
  final String regime;
  final String salary;
  final String seniority;
  final String period;
  final String link;
  final String whatsapp;
  final String email;

  const JobEntity({
    required this.id,
    required this.title,
    required this.companyId,
    required this.companyDescription,
    required this.link,
    required this.whatsapp,
    required this.email,
    required this.period,
    required this.state,
    required this.city,
    required this.description,
    required this.modality,
    required this.regime,
    required this.salary,
    required this.seniority,
  });

  @override
  List<Object> get props => [
        id,
        title,
        companyId,
        companyDescription,
        link,
        whatsapp,
        email,
        period,
        state,
        city,
        description,
        modality,
        regime,
        salary,
        seniority,
      ];
}
