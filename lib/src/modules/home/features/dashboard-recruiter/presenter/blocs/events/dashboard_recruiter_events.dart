import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';

abstract class DashboardRecruiterEvent extends Equatable {
  const DashboardRecruiterEvent();

  @override
  List<Object> get props => [];
}

class LoadDashboardRecruiterEvent extends DashboardRecruiterEvent {}

class AddDashboardRecruiterEvent extends DashboardRecruiterEvent {
  final DashboardRecruiterEntity dashboardRecruiter;

  const AddDashboardRecruiterEvent({required this.dashboardRecruiter});
}

class RemoveDashboardRecruiterEvent extends DashboardRecruiterEvent {
  final DashboardRecruiterEntity dashboardRecruiter;

  const RemoveDashboardRecruiterEvent({required this.dashboardRecruiter});
}
