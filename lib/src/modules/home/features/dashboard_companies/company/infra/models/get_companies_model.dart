import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/domain/entities/get_companies_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/company_model.dart';

class GetCompaniesModel extends GetCompaniesEntity {
  final List<CompanyModel> listCompanyModels;

  const GetCompaniesModel({required this.listCompanyModels})
      : super(listCompanies: listCompanyModels);

  Map<String, dynamic> toMap() {
    return {
      'listCompanyModels': listCompanyModels.map((x) => x.toMap()).toList(),
    };
  }

  factory GetCompaniesModel.fromMap(Map<String, dynamic> map) {
    return GetCompaniesModel(
      listCompanyModels: List<CompanyModel>.from(
          map['listCompanyModels']?.map((x) => CompanyModel.fromMap(x))),
    );
  }
}
