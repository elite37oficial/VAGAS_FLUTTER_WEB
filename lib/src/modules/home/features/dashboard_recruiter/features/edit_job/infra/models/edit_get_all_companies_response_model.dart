import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/entities/edit_get_all_companies_response_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/company_model.dart';

class EditGetAllCompaniesResponseModel
    extends EditGetAllCompaniesResponseEntity {
  final List<CompanyModel> listCompanyModels;

  const EditGetAllCompaniesResponseModel({required this.listCompanyModels})
      : super(listCompanies: listCompanyModels);

  Map<String, dynamic> toMap() {
    return {
      'listCompanyModels': listCompanyModels.map((x) => x.toMap()).toList(),
    };
  }

  factory EditGetAllCompaniesResponseModel.fromMap(Map<String, dynamic> map) {
    return EditGetAllCompaniesResponseModel(
      listCompanyModels: List<CompanyModel>.from(
          map['listCompanyModels']?.map((x) => CompanyModel.fromMap(x))),
    );
  }
}
