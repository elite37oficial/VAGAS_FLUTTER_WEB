import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/entities/admin_create_company_entity.dart';

class AdminCreateCompanyModel extends AdminCreateCompanyEntity {
  const AdminCreateCompanyModel({
    super.id,
    required super.name,
    required super.location,
    required super.description,
    super.image64,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'description': description,
    };
  }

  factory AdminCreateCompanyModel.fromMap(Map<String, dynamic> map) {
    return AdminCreateCompanyModel(
      id: map["id"] as String,
      name: map["name"],
      location: map["location"],
      description: map["description"],
    );
  }
}
