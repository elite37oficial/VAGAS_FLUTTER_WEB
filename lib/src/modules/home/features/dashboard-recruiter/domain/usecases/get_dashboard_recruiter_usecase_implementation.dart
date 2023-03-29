import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/repositories/dashboard_recruiter_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/usecases/get_dashboard_recruiter_usecase.dart';

class GetDashboardRecruiterUsecaseImplementation
    implements GetDashboardRecruiterUseCase {
  final GetDashboardRecruiterRepository _getDashboardJobsRepository;

  GetDashboardRecruiterUsecaseImplementation(this._getDashboardJobsRepository);

  @override
  Future<List<DashboardRecruiterEntity>> call() async {
    return _getDashboardJobsRepository();
  }
}
