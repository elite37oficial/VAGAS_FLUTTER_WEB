import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/datasources/create_job_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/models/create_job_model.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/models/create_job_response_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class CreateJobDatasourceImplementation implements CreateJobDatasource {
  final AppRequester requester;

  const CreateJobDatasourceImplementation({required this.requester});

  @override
  Future createJob(CreateJobModel params) async {
    return await requester.post(
      url: Endpoints.jobs,
      body: params.toMap(),
      fromJson: (value) => CreateJobResponseModel.fromMap(value),
    );
  }
}
