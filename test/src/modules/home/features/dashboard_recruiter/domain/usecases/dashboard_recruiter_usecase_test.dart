import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/repositories/dashboard_recruiter_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/usecases/get_dashboard_recruiter_usecase_implementation.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class MockDashboardRecruiterRepository extends Mock
    implements GetDashboardRecruiterRepository {}

void main() {
  late GetDashboardRecruiterUsecaseImplementation usecase;
  late GetDashboardRecruiterRepository repository;

  setUp(() {
    repository = MockDashboardRecruiterRepository();
    usecase = GetDashboardRecruiterUsecaseImplementation(repository);
  });

  const mockDashboardRecruiter = [
    DashboardRecruiterEntity(
      imageUrl: "image",
      title: "Software Engineer",
      company: "Ifood",
      status: "Open",
      city: "New York",
      type: "Home Office",
    )
  ];

  test('Should get a dashboard recruiter entity', () async {
    when(() => repository.call())
        .thenAnswer((_) async => const Right(mockDashboardRecruiter));
    final result = await usecase();
    expect(result, const Right(mockDashboardRecruiter));
  });

  test('Should return a Server Failure when dont succeed', () async {
    String message = "Server Error!";

    when(() => repository.call()).thenAnswer((_) async =>
        Left<Failure, List<DashboardRecruiterEntity>>(ServerFailure(message)));
    final result = await usecase();
    expect(result, Left(ServerFailure(message)));
  });
}
