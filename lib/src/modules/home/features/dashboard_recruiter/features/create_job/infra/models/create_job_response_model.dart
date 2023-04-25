import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/entities/create_job_response_entity.dart';

class CreateJobResponseModel extends CreateJobResponseEntity {
  const CreateJobResponseModel({required super.jobId});

  Map<String, dynamic> toMap() {
    return {
      'jobId': jobId,
    };
  }

  factory CreateJobResponseModel.fromMap(Map<String, dynamic> map) {
    return CreateJobResponseModel(
      jobId: map['jobId'] ?? '',
    );
  }
}
