import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';

abstract class GetDashboardRecruiterRepository {
  Future<List<DashboardRecruiterEntity>> call();
}
