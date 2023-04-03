import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';

abstract class DashboardRecruiterState extends Equatable {}

class DashboardRecruiterInitialState extends DashboardRecruiterState {
  @override
  List<Object> get props => [];
}

class DashboardRecruiterEmptyState extends DashboardRecruiterState {
  @override
  List<Object> get props => [];
}

class DashboardRecruiterLoadingState extends DashboardRecruiterState {
  @override
  List<Object> get props => [];
}

class DashboardRecruiterErrorState extends DashboardRecruiterState {
  final String message;

  DashboardRecruiterErrorState({required this.message});

  @override
  List<Object> get props => [];
}

class DashboardRecruiterSuccessState extends DashboardRecruiterState {
  final List<DashboardRecruiterEntity> listJobs;

  DashboardRecruiterSuccessState({required this.listJobs});

  @override
  List<Object> get props => [listJobs];
}
