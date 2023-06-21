import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/infra/datasources/admin_create_job_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/infra/models/admin_create_job_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class AdminCreateJobDatasourceImplementation
    implements AdminCreateJobDatasource {
  final AppRequester requester;

  const AdminCreateJobDatasourceImplementation({required this.requester});

  @override
  Future createJob(AdminCreateJobModel params) async {
    return await requester.post(
      url: Endpoints.jobs,
      body: params.toMap(),
      fromJson: (value) {},
    );
  }
}
