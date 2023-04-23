import 'package:equatable/equatable.dart';

class CreateJobEntity extends Equatable {
  final String title;
  final String description;
  final String companyId;
  final String userId;

  const CreateJobEntity({
    required this.title,
    required this.description,
    required this.companyId,
    required this.userId,
  });

  @override
  List<String> get props => [userId, title, description, companyId];
}
