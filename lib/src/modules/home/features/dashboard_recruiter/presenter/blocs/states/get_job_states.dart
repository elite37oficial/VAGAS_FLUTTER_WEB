import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';

abstract class GetJobStates {}

class GetJobInitialState extends GetJobStates {}

class GetJobLoadingState extends GetJobStates {}

class GetJobSuccessState extends GetJobStates {
  final List<JobEntity> listJobs;

  GetJobSuccessState({required this.listJobs});
}

class GetJobErrorState extends GetJobStates {
  final String message;

  GetJobErrorState({required this.message});
}
