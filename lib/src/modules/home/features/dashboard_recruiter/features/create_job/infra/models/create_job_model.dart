import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/entities/create_job_entity.dart';

class CreateJobModel extends CreateJobEntity {
  const CreateJobModel({
    required super.userId,
    required super.title,
    required super.description,
    required super.companyDescription,
    required super.companyId,
    required super.email,
    required super.link,
    required super.phone,
    required super.level,
    required super.type,
    required super.salary,
    required super.state,
    required super.city,
    required super.modality,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'company_id': companyId,
      'company_description': companyDescription,
      'userId': userId,
      "email": email,
      "link": link,
      "whatsapp": phone,
      "seniority": level,
      "regime": type,
      "salary": salary,
      "state": state,
      "city": city,
      "modality": modality,
    };
  }

  factory CreateJobModel.fromMap(Map<String, dynamic> map) {
    return CreateJobModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      companyId: map['company_id'] ?? '',
      userId: map['userId'] ?? '',
      email: map['email'] ?? '',
      level: map['seniority'] ?? '',
      link: map['link'] ?? '',
      phone: map['whatsapp'] ?? '',
      type: map['regime'] ?? '',
      companyDescription: map['company_description'] ?? '',
      city: map['city'] ?? '',
      modality: map['modality'] ?? '',
      salary: map['salary'] ?? 0.00,
      state: map['state'] ?? '',
    );
  }
}
