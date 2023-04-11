import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/repositories/get_job_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/usecases/dashboard_recruiter_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class MockDashboardRecruiterRepository extends Mock
    implements DashboardRecruiterRepository {}

void main() {
  late DashboardRecruiterUsecaseImp usecase;
  late MockDashboardRecruiterRepository mockRepository;

  setUp(() {
    mockRepository = MockDashboardRecruiterRepository();
    usecase = DashboardRecruiterUsecaseImp(repository: mockRepository);
  });

  const tDashboardRecruiterEntity = DashboardRecruiterEntity(
      imageUrl: "image",
      title: "Software Engineer",
      company: "Ifood",
      status: "Open",
      city: "New York",
      type: "Home Office",
      createdAt: "Yesterday");

  test('Should get a dashboard recruiter entity from repository', () async {
    when(() => mockRepository.getJobsInfo())
        .thenAnswer((_) async => const Right(tDashboardRecruiterEntity));
    final result = await usecase();
    expect(result, const Right(tDashboardRecruiterEntity));
  });

  test('Should return a Server Failure when dont succeed', () async {
    String message = "Server Error!";

    when(() => mockRepository.getJobsInfo()).thenAnswer((_) async =>
        Left<Failure, DashboardRecruiterEntity>(ServerFailure(message)));
    final result = await usecase();
    expect(result, Left(ServerFailure(message)));
  });
}
