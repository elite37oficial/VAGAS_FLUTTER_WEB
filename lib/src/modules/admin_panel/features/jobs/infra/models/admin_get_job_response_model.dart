import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/domain/entities/admin_get_job_response_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/job_model.dart';

class AdminGetJobResponseModel extends AdminGetJobResponseEntity {
  final List<JobModel> listJobModels;

  const AdminGetJobResponseModel(
      {required this.listJobModels,
      required super.totalPages,
      required super.actualPage})
      : super(listJobs: listJobModels);

  Map<String, dynamic> toMap() {
    return {
      'listJobModels': listJobModels.map((x) => x.toMap()).toList(),
      'totalPages': totalPages,
      'actualPages': actualPage,
    };
  }

  factory AdminGetJobResponseModel.fromMap(Map<String, dynamic> map) {
    return AdminGetJobResponseModel(
      listJobModels:
          List<JobModel>.from(map['data']?.map((x) => JobModel.fromMap(x))),
      totalPages: map['totalPages'] ?? '',
      actualPage: map['actualPage'] ?? '',
    );
  }
}
