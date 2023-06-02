import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/domain/entities/get_job_response_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/job_model.dart';

class GetJobResponseModel extends GetJobResponseEntity {
  final List<JobModel> listJobModels;

  const GetJobResponseModel(
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

  factory GetJobResponseModel.fromMap(Map<String, dynamic> map) {
    return GetJobResponseModel(
      listJobModels:
          List<JobModel>.from(map['data']?.map((x) => JobModel.fromMap(x))),
      totalPages: map['totalPages'] ?? '',
      actualPage: map['actualPage'] ?? '',
    );
  }
}
