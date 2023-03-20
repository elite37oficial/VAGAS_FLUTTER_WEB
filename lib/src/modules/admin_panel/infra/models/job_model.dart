import 'package:vagas_flutter_web/src/modules/admin_panel/domain/entities/job_entity.dart';

class JobModel extends JobEntity {
  const JobModel({
    required super.id,
    required super.title,
    required super.enterprise,
    required super.link,
    required super.imageLogo,
    required super.local,
    required super.period,
    required super.createdAt,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'enterprise': enterprise,
      'link': link,
      'imageLogo': imageLogo,
      'local': local,
      'period': period,
      'createdAt': createdAt,
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      id: map["id"] ?? "",
      title: map["title"] ?? "",
      enterprise: map["enterprise"] ?? "",
      link: map["link"] ?? "",
      imageLogo: map["imageLogo"] ?? "",
      local: map["local"] ?? "",
      period: map["period"] ?? "",
      createdAt: map["createdAt"] ?? "",
    );
  }
}
