import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/repositories/dashboard_recruiter_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/usecases/get_dashboard_recruiter_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class GetDashboardRecruiterUsecaseImplementation
    implements GetDashboardRecruiterUseCase {
  final GetDashboardRecruiterRepository _getDashboardJobsRepository;

  GetDashboardRecruiterUsecaseImplementation(this._getDashboardJobsRepository);

  @override
  Future<Either<Failure, List<DashboardRecruiterEntity>>> call() async {
    try {
      final result = await _getDashboardJobsRepository.call();
      return result;
    } on ServerException {
      return Left(ServerFailure('Server Error!'));
    }
  }
}
