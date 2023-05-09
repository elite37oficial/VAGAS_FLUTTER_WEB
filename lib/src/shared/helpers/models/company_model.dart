import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';

class CompanyModel extends CompanyEntity {
  const CompanyModel({
    required super.id,
    required super.name,
    required super.location,
    required super.description,
    required super.status,
    required super.image64,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'status': status,
      'image64': image64,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      location: map["location"] ?? "",
      description: map["description"] ?? "",
      status: map["status"] ?? "",
      image64: map["image64"] ?? "",
    );
  }
}
