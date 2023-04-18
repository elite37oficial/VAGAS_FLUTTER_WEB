import 'package:flutter_test/flutter_test.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/job_model.dart';

main() {
  late JobModel jobModel;

  setUp(() {
    jobModel = const JobModel(
      id: "1",
      title: "titulo",
      enterprise: "teste",
      local: "local",
      imageLogo: "image",
      link: "www.teste.com",
      period: "FullTime",
      createdAt: "2017-09-07",
    );
  });

  test("Should be a subclass of JobEntity", () {
    expect(jobModel, isA<JobEntity>());
  });

  test("Should return a valid JobModel from a Map", () {
    final Map<String, dynamic> map = {
      "id": "1",
      "title": "titulo",
      "enterprise": "teste",
      "local": "local",
      "imageLogo": "image",
      "link": "www.teste.com",
      "period": "FullTime",
      "createdAt": "2017-09-07",
    };

    final result = JobModel.fromMap(map);

    expect(result, isA<JobModel>());
  });

  test("Should return Map containing the JobModel data", () {
    final expectedMap = {
      "id": "1",
      "title": "titulo",
      "enterprise": "teste",
      "local": "local",
      "imageLogo": "image",
      "link": "www.teste.com",
      "period": "FullTime",
      "createdAt": "2017-09-07",
    };

    final result = jobModel.toMap();

    expect(result, expectedMap);
  });
}
