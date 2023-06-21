import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/infra/models/admin_create_job_model.dart';

abstract class AdminCreateJobDatasource {
  Future createJob(AdminCreateJobModel params);
}
