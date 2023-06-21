import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/entities/admin_create_job_response_entity.dart';

class AdminCreateJobResponseModel extends AdminCreateJobResponseEntity {
  const AdminCreateJobResponseModel({required super.jobId});

  Map<String, dynamic> toMap() {
    return {
      'jobId': jobId,
    };
  }

  factory AdminCreateJobResponseModel.fromMap(Map<String, dynamic> map) {
    return AdminCreateJobResponseModel(
      jobId: map['jobId'] ?? '',
    );
  }
}
