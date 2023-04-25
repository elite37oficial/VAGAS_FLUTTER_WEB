import 'package:vagas_flutter_web/src/shared/helpers/models/company_model.dart';

class GetCompanyModel {
  final List<CompanyModel> listCompanies;

  GetCompanyModel({required this.listCompanies});

  Map<String, dynamic> toMap() {
    return {
      'listCompanies': listCompanies.map((x) => x.toMap()).toList(),
    };
  }

  factory GetCompanyModel.fromMap(Map<String, dynamic> map) {
    return GetCompanyModel(
      listCompanies: List<CompanyModel>.from(
          map['listCompanies']?.map((x) => CompanyModel.fromMap(x))),
    );
  }
}
