import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/models/dashboard_recruiter_model.dart';

abstract class GetDashboardRecruiterDatasource {
  Future<List<DashboardRecruiterModel>> call();
}
