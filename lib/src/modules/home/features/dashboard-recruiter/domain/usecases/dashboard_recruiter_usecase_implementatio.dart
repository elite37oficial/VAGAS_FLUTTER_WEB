import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/repositories/dashboard_recruiter_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/usecases/dashboard_recruiter_usecase.dart';

class DashboardRecruiterUsecaseImp implements GetDashboardRecruiterUseCase {
  final GetDashboardRecruiterRepository _getDashboardRepository;

  DashboardRecruiterUsecaseImp(this._getDashboardRepository);

  @override
  Future<List<DashboardRecruiterEntity>> call() async {
    return _getDashboardRepository();
  }
}
