import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/domain/entities/change_image_entity.dart';

class ChangeImageModel extends ChangeImageEntity {
  const ChangeImageModel({
    required super.companyId,
    required super.image64,
  });
  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'image64': image64,
    };
  }

  factory ChangeImageModel.fromMap(Map<String, dynamic> map) {
    return ChangeImageModel(
      companyId: map["companyId"],
      image64: map["image64"],
    );
  }
}
