import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/infra/datasources/admin_get_job_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/infra/models/admin_get_job_response_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class AdminGetJobDatasourceImplementation implements AdminGetJobDatasource {
  final AppRequester requester;

  AdminGetJobDatasourceImplementation({required this.requester});

  @override
  Future adminGetJob(int page) async {
    return await requester.get(
        url: Endpoints.pageJobsAdmin(page),
        fromJson: (value) => AdminGetJobResponseModel.fromMap(value));
  }
}
