import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/entities/admin_change_image_entity.dart';

class AdminChangeImageModel extends AdminChangeImageEntity {
  const AdminChangeImageModel({
    required String? companyId,
    required String? image64,
  }) : super(companyId: companyId, image64: image64);
  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'image64': image64,
    };
  }

  factory AdminChangeImageModel.fromMap(Map<String, dynamic> map) {
    return AdminChangeImageModel(
      companyId: map["companyId"],
      image64: map["image64"],
    );
  }
}
