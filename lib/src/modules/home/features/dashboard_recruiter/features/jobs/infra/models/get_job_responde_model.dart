import 'package:vagas_flutter_web/src/shared/helpers/models/job_model.dart';

class GetJobResponseModel {
  final List<JobModel> listJobs;

  GetJobResponseModel({required this.listJobs});

  Map<String, dynamic> toMap() {
    return {
      'listJobs': listJobs.map((x) => x.toMap()).toList(),
    };
  }

  factory GetJobResponseModel.fromMap(List<dynamic> list) {
    return GetJobResponseModel(
      listJobs: List<JobModel>.from(list.map((x) => JobModel.fromMap(x))),
    );
  }
}
