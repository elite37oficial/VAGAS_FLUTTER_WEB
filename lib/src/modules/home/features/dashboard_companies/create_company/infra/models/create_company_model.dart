import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/domain/entities/create_company_entity.dart';

class CreateCompanyModel extends CreateCompanyEntity {
  const CreateCompanyModel({
    required super.name,
    required super.location,
    required super.description,
    required super.status,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'description': description,
      'status': status,
    };
  }

  factory CreateCompanyModel.fromMap(Map<String, dynamic> map) {
    return CreateCompanyModel(
      name: map["name"] ?? "",
      location: map["location"] ?? "",
      description: map["description"] ?? "",
      status: map["status"] ?? "",
    );
  }
}
