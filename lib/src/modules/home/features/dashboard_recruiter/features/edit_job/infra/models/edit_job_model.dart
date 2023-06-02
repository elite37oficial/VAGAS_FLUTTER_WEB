import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/entities/edit_job_entity.dart';

class EditJobModel extends EditJobEntity {
  const EditJobModel({
    required super.id,
    required super.salary,
    required super.state,
    required super.status,
    required super.city,
    required super.companyDescription,
    required super.companyId,
    required super.description,
    required super.email,
    required super.title,
    required super.type,
    required super.level,
    required super.link,
    required super.modality,
    required super.phone,
    required super.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'company_id': companyId,
      'regime': type,
      'seniority': level,
      'whatsapp': phone,
      'email': email,
      'modality': modality,
      'link': link,
      'salary': salary,
      'state': state,
      'city': city,
    };
  }

  factory EditJobModel.fromMap(Map<String, dynamic> map) {
    return EditJobModel(
      id: map['id'] ?? '',
      status: map['status'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      companyDescription: map['companyDescription'] ?? '',
      companyId: map['company_id'] ?? '',
      type: map['regime'] ?? '',
      userId: map['userId'] ?? '',
      level: map['seniority'] ?? '',
      phone: map['whatsapp'] ?? '',
      email: map['email'] ?? '',
      modality: map['modality'] ?? '',
      link: map['link'] ?? '',
      salary: map['salary']?.toDouble() ?? 0.0,
      state: map['state'] ?? '',
      city: map['city'] ?? '',
    );
  }
}
