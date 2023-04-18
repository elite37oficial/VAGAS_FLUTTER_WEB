import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/infra/datasources/get_company_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/infra/models/get_company_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class GetCompanyDatasourceImplementation implements GetCompanyDatasource {
  final AppRequester requester;

  GetCompanyDatasourceImplementation({required this.requester});

  @override
  Future getCompany() async {
    return await requester.get(
      url: Endpoints.companies,
      fromJson: (value) => GetCompanyModel.fromMap(value),
    );
  }
}
