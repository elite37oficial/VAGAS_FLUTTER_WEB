import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/infra/datasources/get_job_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/infra/models/get_job_responde_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class GetJobDatasourceImplementation implements GetJobDatasource {
  final AppRequester requester;

  GetJobDatasourceImplementation({required this.requester});

  @override
  Future getJob() async {
    return await requester.get(
        url: Endpoints.dashboardGetJobs,
        fromJson: (value) => GetJobResponseModel.fromMap(value));
  }
}
