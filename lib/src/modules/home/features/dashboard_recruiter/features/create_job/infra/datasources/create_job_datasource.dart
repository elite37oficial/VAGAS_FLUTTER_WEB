import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/models/create_job_model.dart';

abstract class CreateJobDatasource {
  Future createJob(CreateJobModel params);
}
