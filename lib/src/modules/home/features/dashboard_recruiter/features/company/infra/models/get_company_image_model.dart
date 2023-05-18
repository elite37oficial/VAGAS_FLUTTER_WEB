import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/domain/entities/get_company_image_entity.dart';

class GetCompanyImageModel extends GetCompanyImageEntity {
  const GetCompanyImageModel({
    super.companyId,
    required super.image64,
  });

  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
    };
  }

  factory GetCompanyImageModel.fromMap(Map<String, dynamic> map) {
    return GetCompanyImageModel(
      image64: map["companyd"],
    );
  }
}
