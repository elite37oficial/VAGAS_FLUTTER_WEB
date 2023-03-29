import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';

abstract class DashboardRecruiterState {}

class EmptyDashboardRecruiterState implements DashboardRecruiterState {}

class ErrorDashboardRecruiterState implements DashboardRecruiterState {
  final String? message;

  ErrorDashboardRecruiterState(this.message);
}

class ListJobsDashboardRecruiterState implements DashboardRecruiterState {
  final List<DashboardRecruiterEntity> listJobs;
  ListJobsDashboardRecruiterState({required this.listJobs});
}

class LoadingDashboardRecruiterState implements DashboardRecruiterState {}
