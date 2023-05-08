import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/entities/get_companies_response_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/company_model.dart';

class GetCompaniesResponseModel extends GetCompaniesResponseEntity {
  final List<CompanyModel> listCompanyModels;

  const GetCompaniesResponseModel({required this.listCompanyModels})
      : super(listCompanies: listCompanyModels);

  Map<String, dynamic> toMap() {
    return {
      'listCompanyModels': listCompanyModels.map((x) => x.toMap()).toList(),
    };
  }

  factory GetCompaniesResponseModel.fromMap(Map<String, dynamic> map) {
    return GetCompaniesResponseModel(
      listCompanyModels: List<CompanyModel>.from(
          map['listCompanyModels']?.map((x) => CompanyModel.fromMap(x))),
    );
  }
}
