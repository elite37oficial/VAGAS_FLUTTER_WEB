import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/datasources/dashboard_recruiter_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/models/dashboard_recruiter_model.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class GetDashboardDataSourceImp implements GetDashboardRecruiterDatasource {
  final AppRequester requester;

  GetDashboardDataSourceImp({required this.requester});

  final dataMock = [
    DashboardRecruiterModel(
        imageUrl:
            'https://static.ifood.com.br/webapp/images/logo-smile-512x512.png',
        title: 'Software Engineer',
        company: 'Ifood',
        status: 'Open',
        city: 'New York',
        type: 'Home Office'),
  ];

  @override
  Future<List<DashboardRecruiterModel>> call() async {
    final listJobs = await dataMock;
    return listJobs;
  }
}
