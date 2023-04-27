import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';

class CompanyModel extends CompanyEntity {
  const CompanyModel({
    required super.id,
    required super.name,
    required super.location,
    required super.description,
    required super.status,
    required super.image64,
    required super.state,
    required super.city,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': "$city - $state",
      'description': description,
      'status': status,
      'image64': image64,
      'state': state,
      'city': city,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    final location = map['location'] ?? "";
    final state = location['state']?.toString().split(" - ")[0] ?? '';
    final city = location['city']?.toString().split(" - ")[1] ?? '';

    return CompanyModel(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      location: location,
      description: map["description"] ?? "",
      status: map["status"] ?? "",
      image64: map["image64"] ?? "",
      state: state,
      city: city,
    );
  }
}
