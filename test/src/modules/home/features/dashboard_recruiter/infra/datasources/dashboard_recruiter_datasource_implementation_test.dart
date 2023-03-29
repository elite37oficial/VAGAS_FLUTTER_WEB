import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/datasources/get_users_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/datasources/dashboard_recruiter_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/datasources/dashboard_recruiter_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/models/dashboard_recruiter_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class AppRequesterMock extends Mock implements AppRequester {}

void main() {
  late GetDashboardRecruiterDatasource datasource;
  late AppRequester requester;

  setUp(() {
    requester = AppRequesterMock();
    datasource = DashboardDatasourceImplementation(requester);
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
