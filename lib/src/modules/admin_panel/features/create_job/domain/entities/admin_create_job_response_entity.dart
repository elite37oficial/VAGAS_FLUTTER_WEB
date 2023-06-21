import 'package:equatable/equatable.dart';

class AdminCreateJobResponseEntity extends Equatable {
  final String jobId;

  const AdminCreateJobResponseEntity({required this.jobId});

  @override
  List<String> get props => [jobId];
}
