import 'package:equatable/equatable.dart';

abstract class CreateJobEvent extends Equatable {
  const CreateJobEvent();
}

class DoCreateJobEvent extends CreateJobEvent {
  final String title;
  final String description;
  final String companyId;
  final String userId;

  const DoCreateJobEvent({
    required this.title,
    required this.description,
    required this.companyId,
    required this.userId,
  });

  @override
  List<Object> get props => [userId, title, description, companyId];
}
