import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class AppRequesterMock extends Mock implements AppRequester {}

void main() {
  late GetDashboardRecruiterDatasourceImplementation datasource;
  late AppRequester requester;

  setUp(() {
    requester = AppRequesterMock();
    datasource = GetDashboardRecruiterDatasourceImplementation();
  });

  // DashboardRecruiterModel dashboardRecruiterModelFromJson(dynamic json) {
  //   return DashboardRecruiterModel.fromMap(json as Map<String, dynamic>);
  // }

  test('Should call the get method with correctly url', () async {
    // when(() async => await requester.get(
    //       url: Endpoints.dashboardRecruiter,
    //       fromJson: (value) => dashboardRecruiterModelFromJson(value),
    //     ));

    // await datasource.getDashboardRecruiterEntity();
  });
}

class GetDashboardRecruiterDatasourceImplementation {}
