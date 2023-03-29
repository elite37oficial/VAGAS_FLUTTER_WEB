import 'package:equatable/equatable.dart';

class DashboardRecruiterEntity extends Equatable {
  final String imageUrl;
  final String title;
  final String company;
  final String status;
  final String city;
  final String type;

  const DashboardRecruiterEntity({
    required this.imageUrl,
    required this.title,
    required this.company,
    required this.status,
    required this.city,
    required this.type,
  });

  @override
  List<Object> get props => [imageUrl, title, company, status, city, type];
}
