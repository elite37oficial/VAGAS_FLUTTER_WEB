import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/entities/edit_image_entity.dart';

class EditImageModel extends EditImageEntity {
  const EditImageModel({
    required String? companyId,
    required String? image64,
  }) : super(companyId: companyId, image64: image64);
  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'image64': image64,
    };
  }

  factory EditImageModel.fromMap(Map<String, dynamic> map) {
    return EditImageModel(
      companyId: map["companyId"],
      image64: map["image64"],
    );
  }
}
