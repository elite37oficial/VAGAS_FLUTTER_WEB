import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/models/get_job_responde_model.dart';

import '../mocks/dashboard_recruiter_mock.dart';

void main() {
  const tDashboardRecruiterModel = DashboardRecruiterModel(
    imageUrl: "image",
    title: "Software Engineer",
    company: "Ifood",
    status: "Open",
    city: "New York",
    type: "Home Office",
    createdAt: "Yesterday",
  );

  test('Should be a subclass of DashboardRecruiterEntity', () {
    expect(tDashboardRecruiterModel, isA<DashboardRecruiterEntity>());
  });

  test('Should return a valid model', () {
    final Map<String, dynamic> map = json.decode(dashboardRecruiterMock);
    final result = DashboardRecruiterModel.fromMap(map);
    expect(result, tDashboardRecruiterModel);
  });

  test('Should return a map containing the proper data', () {
    final expectedMap = {
      "imageUrl": "image",
      "title": "Software Engineer",
      "company": "Ifood",
      "status": "Open",
      "city": "New York",
      "type": "Home Office",
      "createdAt": "Yesterday"
    };
    final result = tDashboardRecruiterModel.toMap();
    expect(result, expectedMap);
  });
}
