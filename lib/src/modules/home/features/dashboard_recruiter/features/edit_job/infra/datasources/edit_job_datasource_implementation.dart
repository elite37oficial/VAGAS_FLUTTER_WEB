import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/datasources/edit_job_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/models/edit_job_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class EditJobDatasourceImplementation implements EditJobDatasource {
  final AppRequester requester;

  const EditJobDatasourceImplementation({required this.requester});

  @override
  Future editJob(EditJobModel editJobModel) async {
    return await requester.put(
      url: Endpoints.jobs,
      body: editJobModel.toMap(),
      fromJson: (value) {},
    );
  }
}
