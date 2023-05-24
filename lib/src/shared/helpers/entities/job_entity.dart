import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String companyId;
  final String companyName;
  final String companyDescription;
  final String state;
  final String city;
  final String modality;
  final String regime;
  final double salary;
  final String seniority;
  final String period;
  final String link;
  final String whatsapp;
  final String email;
  final String status;
  final int createdDate;

  const JobEntity({
    required this.id,
    required this.title,
    required this.companyId,
    required this.companyName,
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
    required this.status,
    required this.createdDate,
  });

  @override
  List<Object> get props => [
        id,
        title,
        companyId,
        companyName,
        companyDescription,
        link,
        whatsapp,
        email,
        period,
        state,
        city,
        description,
        status,
        modality,
        regime,
        salary,
        seniority,
        createdDate,
      ];
}
