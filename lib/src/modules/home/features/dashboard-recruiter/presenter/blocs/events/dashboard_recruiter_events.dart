import 'package:equatable/equatable.dart';

abstract class DashboardRecruiterEvent extends Equatable {
  const DashboardRecruiterEvent();

  @override
  List<Object> get props => [];
}

class GetDashboardRecruiterEvent extends DashboardRecruiterEvent {}
