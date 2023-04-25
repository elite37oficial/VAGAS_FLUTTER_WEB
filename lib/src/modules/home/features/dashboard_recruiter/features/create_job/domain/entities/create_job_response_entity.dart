import 'package:equatable/equatable.dart';

class CreateJobResponseEntity extends Equatable {
  final String jobId;

  const CreateJobResponseEntity({required this.jobId});

  @override
  List<String> get props => [jobId];
}
