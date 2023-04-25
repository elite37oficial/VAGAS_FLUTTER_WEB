import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/entities/create_job_response_entity.dart';

abstract class CreateJobStates {}

class CreateJobInitialState extends CreateJobStates {}

class CreateJobLoadingState extends CreateJobStates {}

class CreateJobSuccessState extends CreateJobStates {
  final CreateJobResponseEntity response;

  CreateJobSuccessState({required this.response});
}

class CreateJobErrorState extends CreateJobStates {
  final String message;

  CreateJobErrorState({required this.message});
}
