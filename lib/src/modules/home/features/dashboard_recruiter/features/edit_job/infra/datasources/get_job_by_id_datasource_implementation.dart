import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/datasources/get_job_by_id_datasource.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/job_model.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class GetJobByIdDatasourceImplementation implements GetJobByIdDatasource {
  final AppRequester requester;

  const GetJobByIdDatasourceImplementation({required this.requester});

  @override
  Future getJobById(String jobId) async {
    return await requester.get(
      url: Endpoints.jobsById(jobId),
      fromJson: (value) => JobModel.fromMap(value),
    );
  }
}
