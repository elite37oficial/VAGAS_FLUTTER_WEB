import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

abstract class GetDashboardRecruiterUseCase {
  Future<Either<Failure, List<DashboardRecruiterEntity>>> call();
}
