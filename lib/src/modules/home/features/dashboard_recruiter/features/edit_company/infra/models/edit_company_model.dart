import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/entities/edit_company_entity.dart';

class EditCompanyModel extends EditCompanyEntity {
  const EditCompanyModel({
    required super.id,
    required super.name,
    required super.location,
    required super.description,
    super.image64,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'description': description,
    };
  }

  factory EditCompanyModel.fromMap(Map<String, dynamic> map) {
    return EditCompanyModel(
      id: map["id"],
      name: map["name"],
      location: map["location"],
      description: map["description"],
    );
  }
}
