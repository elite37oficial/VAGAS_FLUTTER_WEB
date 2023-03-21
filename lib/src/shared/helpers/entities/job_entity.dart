import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final String id;
  final String title;
  final String enterprise;
  final String link;
  final String imageLogo;
  final String local;
  final String period;
  final String createdAt;

  const JobEntity({
    required this.id,
    required this.title,
    required this.enterprise,
    required this.link,
    required this.imageLogo,
    required this.local,
    required this.period,
    required this.createdAt,
  });

  @override
  List<Object> get props => [
        id,
        title,
        enterprise,
        link,
        imageLogo,
        local,
        period,
        createdAt,
      ];
}
