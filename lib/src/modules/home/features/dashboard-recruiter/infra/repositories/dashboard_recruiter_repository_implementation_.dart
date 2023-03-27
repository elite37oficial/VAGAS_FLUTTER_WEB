import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/repositories/dashboard_recruiter_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/datasources/dashboard_recruiter_datasource.dart';

class DashboardRecruiterRepositoryImplementation
    implements GetDashboardRecruiterRepository {
  final GetDashboardRecruiterDatasource datasource;

  DashboardRecruiterRepositoryImplementation({required this.datasource});

  @override
  Future<List<DashboardRecruiterEntity>> call() async {
    return datasource();
  }
}
