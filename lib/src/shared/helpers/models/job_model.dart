import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';

class JobModel extends JobEntity {
  const JobModel({
    required super.id,
    required super.title,
    required super.companyId,
    required super.companyName,
    required super.companyDescription,
    required super.link,
    required super.whatsapp,
    required super.email,
    required super.period,
    required super.state,
    required super.city,
    required super.status,
    required super.description,
    required super.modality,
    required super.regime,
    required super.salary,
    required super.seniority,
    required super.createdDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'companyId': companyId,
      'companyName': companyName,
      'companyDescription': companyDescription,
      'state': state,
      'city': city,
      'modality': modality,
      'regime': regime,
      'status': status,
      'salary': salary,
      'seniority': seniority,
      'period': period,
      'link': link,
      'whatsapp': whatsapp,
      'email': email,
      'createdDate': createdDate,
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      companyId: map['companyId'] ?? '',
      companyName: map['companyName'] ?? '',
      companyDescription: map['companyDescription'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      modality: map['modality'] ?? '',
      regime: map['regime'] ?? '',
      salary: map['salary'] ?? 0.0,
      seniority: map['seniority'] ?? '',
      period: map['period'] ?? '',
      link: map['link'] ?? '',
      whatsapp: map['whatsapp'] ?? '',
      email: map['email'] ?? '',
      status: map['status'] ?? '',
      createdDate: map['createdDate'] ?? 0,
    );
  }
}
