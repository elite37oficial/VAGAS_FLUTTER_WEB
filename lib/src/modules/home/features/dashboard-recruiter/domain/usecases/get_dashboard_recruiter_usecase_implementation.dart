import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/repositories/dashboard_recruiter_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/usecases/get_dashboard_recruiter_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class GetDashboardRecruiterUsecaseImplementation
    implements GetDashboardRecruiterUsecase {
  final GetDashboardRecruiterRepository getDashboardJobsRepository;

  GetDashboardRecruiterUsecaseImplementation(
      {required this.getDashboardJobsRepository});

  @override
  Future<Either<Failure, List<DashboardRecruiterEntity>>> call() async {
    try {
      final result = await getDashboardJobsRepository.call();
      return result;
    } on ServerException {
      return Left(ServerFailure('Server Error!'));
    }
  }
}
