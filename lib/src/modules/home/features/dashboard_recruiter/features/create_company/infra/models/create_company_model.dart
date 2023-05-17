import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/domain/entities/create_company_entity.dart';

class CreateCompanyModel extends CreateCompanyEntity {
  const CreateCompanyModel({
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

  factory CreateCompanyModel.fromMap(Map<String, dynamic> map) {
    return CreateCompanyModel(
      id: map["id"] as String,
      name: map["name"],
      location: map["location"],
      description: map["description"],
    );
  }
}
