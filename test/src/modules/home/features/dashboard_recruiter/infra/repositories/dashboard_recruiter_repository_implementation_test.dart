import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/datasources/dashboard_recruiter_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/models/dashboard_recruiter_model.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/repositories/dashboard_recruiter_repository_implementation.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class MockDashboardRecruiterDatasource extends Mock
    implements GetDashboardRecruiterDatasource {}

void main() {
  late DashboardRecruiterRepositoryImplementation repository;
  late GetDashboardRecruiterDatasource datasource;

  setUp(() {
    datasource = MockDashboardRecruiterDatasource();
    repository = DashboardRecruiterRepositoryImplementation(datasource);
  });

  const tDashboardRecruiterModel = [
    DashboardRecruiterModel(
      imageUrl: "image",
      title: "Software Engineer",
      company: "Ifood",
      status: "Open",
      city: "New York",
      type: "Home Office",
    )
  ];

  test('Should return a dashboard recruiter entity when calls the datasource',
      () async {
    when(() => datasource.call())
        .thenAnswer((_) async => (tDashboardRecruiterModel));

    final result = await repository.call();
    expect(result, tDashboardRecruiterModel);

    verify(() => datasource.call()).called(1);
  });

  test(
      'Should return a Server Failure when the call to datasource is unsuccessful',
      () async {
    var message = "Server Error!";
    when(() => datasource.call())
        .thenThrow(ServerException(message: message, statusCode: 500));

    final result = await repository.call();

    expect(result, ServerFailure(message));
    verify(() => datasource.call()).called(1);
  });
}
