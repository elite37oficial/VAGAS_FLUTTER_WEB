import 'dart:convert';

import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';

class DashboardRecruiterModel extends DashboardRecruiterEntity {
  const DashboardRecruiterModel({
    required String imageUrl,
    required String title,
    required String company,
    required String status,
    required String city,
    required String type,
  }) : super(
          imageUrl: imageUrl,
          title: title,
          company: company,
          status: status,
          city: city,
          type: type,
        );

  factory DashboardRecruiterModel.fromMap(Map<String, dynamic> map) {
    return DashboardRecruiterModel(
      imageUrl: map['imageUrl'] as String,
      title: map['title'] as String,
      company: map['company'] as String,
      status: map['status'] as String,
      city: map['city'] as String,
      type: map['type'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'title': title,
      'company': company,
      'status': status,
      'city': city,
      'type': type,
    };
  }

  String toJson() => json.encode(toMap());
  factory DashboardRecruiterModel.fromJson(String source) =>
      DashboardRecruiterModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
