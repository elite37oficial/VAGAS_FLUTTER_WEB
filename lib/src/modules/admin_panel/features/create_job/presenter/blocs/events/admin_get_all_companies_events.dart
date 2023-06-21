import 'package:equatable/equatable.dart';

abstract class AdminGetAllCompaniesEvent extends Equatable {
  const AdminGetAllCompaniesEvent();
}

class DoAdminGetAllCompaniesEvent extends AdminGetAllCompaniesEvent {
  @override
  List<Object> get props => [];
}
