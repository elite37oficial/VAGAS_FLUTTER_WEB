import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/domain/entities/create_company_entity.dart';

class CreateCompanyModel extends CreateCompanyEntity {
  const CreateCompanyModel({
    required super.name,
    required super.location,
    required super.description,
    required super.state,
    required super.city,
  });
  Map<String?, dynamic> toMap() {
    return {
      'name': name,
      'location': "$city - $state",
      'description': description,
    };
  }

  factory CreateCompanyModel.fromMap(Map<String?, dynamic> map) {
    final location = map['location'] ?? {};
    final state = location['state']?.split(" - ")[0] ?? '';
    final city = location['city']?.split(" - ")[1] ?? '';

    return CreateCompanyModel(
      name: map["name"] ?? "",
      location: map["location"] ?? "",
      description: map["description"] ?? "",
      state: state,
      city: city,
    );
  }
}
