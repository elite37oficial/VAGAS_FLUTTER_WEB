import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/infra/datasources/get_job_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/infra/models/get_job_responde_model.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/infra/repositories/get_job_repository_implementation.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class MockDashboardRecruiterDataSource extends Mock
    implements DashboardRecruiterDataSource {}

void main() {
  late DashboardRecruiterRepositoryImplementation repository;
  late MockDashboardRecruiterDataSource datasource;

  setUp(() {
    datasource = MockDashboardRecruiterDataSource();
    repository = DashboardRecruiterRepositoryImplementation(
        dashboardRecruiterDataSource: datasource);
  });

  const tDashboardRecruiterModel = DashboardRecruiterModel(
    imageUrl: "image",
    title: "Software Engineer",
    company: "Ifood",
    status: "Open",
    city: "New York",
    type: "Home Office",
    createdAt: "Yesterday",
  );

  test('Should return a dashboard recruiter entity when calls the datasource',
      () async {
    when(() => datasource.getJobsInfo())
        .thenAnswer((_) async => const Right(tDashboardRecruiterModel));

    final result = await repository.getJobsInfo();
    expect(result, const Right(tDashboardRecruiterModel));
  });

  test(
      'Should return a Server Failure when the call to datasource is unsuccessful',
      () async {
    String message = "Server Error!";

    when(() => datasource.call())
        .thenAnswer((_) async => throw ServerException());

    final result = await repository.dashboardRecruiterDataSource();

    expect(result, ServerFailure(message));
    verify(() => datasource.call()).called(1);
  });
}
