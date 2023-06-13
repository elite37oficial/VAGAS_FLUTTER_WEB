import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/domain/entities/admin_get_job_response_entity.dart';

abstract class AdminGetJobStates {}

class AdminGetJobInitialState extends AdminGetJobStates {}

class AdminGetJobLoadingState extends AdminGetJobStates {}

class AdminGetJobSuccessState extends AdminGetJobStates {
  final AdminGetJobResponseEntity listJobs;

  AdminGetJobSuccessState({required this.listJobs});
}

class AdminGetJobErrorState extends AdminGetJobStates {
  final String message;

  AdminGetJobErrorState({required this.message});
}
