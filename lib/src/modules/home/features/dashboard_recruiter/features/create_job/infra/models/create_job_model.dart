import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/entities/create_job_entity.dart';

class CreateJobModel extends CreateJobEntity {
  const CreateJobModel({
    required super.userId,
    required super.title,
    required super.description,
    required super.companyId,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'companyId': companyId,
      'userId': userId,
    };
  }

  factory CreateJobModel.fromMap(Map<String, dynamic> map) {
    return CreateJobModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      companyId: map['companyId'] ?? '',
      userId: map['userId'] ?? '',
    );
  }
}
