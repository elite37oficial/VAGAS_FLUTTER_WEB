import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/entities/get_company_entity.dart';

class GetCompanyModel extends GetCompanyEntity {
  const GetCompanyModel({
    required super.id,
    required super.name,
    required super.location,
    required super.description,
    required super.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'status': status,
    };
  }

  factory GetCompanyModel.fromMap(Map<String, dynamic> map) {
    return GetCompanyModel(
      id: map["id"],
      name: map["name"],
      location: map["location"],
      description: map["description"],
      status: map["status"],
    );
  }
}
