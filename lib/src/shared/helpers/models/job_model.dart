import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';

class JobModel extends JobEntity {
  const JobModel({
    required super.id,
    required super.title,
    required super.companyId,
    required super.companyDescription,
    required super.link,
    required super.whatsapp,
    required super.email,
    required super.period,
    required super.state,
    required super.city,
    required super.description,
    required super.modality,
    required super.regime,
    required super.salary,
    required super.seniority,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'companyId': companyId,
      'companyDescription': companyDescription,
      'state': state,
      'city': city,
      'modality': modality,
      'regime': regime,
      'salary': salary,
      'seniority': seniority,
      'period': period,
      'link': link,
      'whatsapp': whatsapp,
      'email': email,
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      companyId: map['companyId'] ?? '',
      companyDescription: map['companyDescription'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      modality: map['modality'] ?? '',
      regime: map['regime'] ?? '',
      salary: map['salary'] ?? '',
      seniority: map['seniority'] ?? '',
      period: map['period'] ?? '',
      link: map['link'] ?? '',
      whatsapp: map['whatsapp'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
