import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/repositories/dashboard_recruiter_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/datasources/dashboard_recruiter_datasource.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class DashboardRecruiterRepositoryImplementation
    implements GetDashboardRecruiterRepository {
  final GetDashboardRecruiterDatasource getDashboardJobsDatasource;

  DashboardRecruiterRepositoryImplementation(
      {required this.getDashboardJobsDatasource});

  @override
  Future<Either<Failure, List<DashboardRecruiterEntity>>> call() async {
    try {
      final result = await getDashboardJobsDatasource();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure('Server Error!'));
    }
  }
}
