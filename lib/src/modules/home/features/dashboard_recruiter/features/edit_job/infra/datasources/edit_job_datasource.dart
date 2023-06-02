import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/models/edit_job_model.dart';

abstract class EditJobDatasource {
  Future editJob(EditJobModel editJobModel);
}
