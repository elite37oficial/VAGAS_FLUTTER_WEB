import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/datasources/get_companies_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/models/get_companies_response_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class GetCompaniesDatasourceImplementation implements GetCompaniesDatasource {
  final AppRequester requester;

  const GetCompaniesDatasourceImplementation({required this.requester});

  @override
  Future getCompanies() async {
    return await requester.get(
      url: Endpoints.companies,
      fromJson: (value) =>
          GetCompaniesResponseModel.fromMap({"listCompanyModels": value}),
    );
  }
}
