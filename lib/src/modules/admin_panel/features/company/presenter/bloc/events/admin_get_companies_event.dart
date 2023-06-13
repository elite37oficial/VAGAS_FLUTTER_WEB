import 'package:equatable/equatable.dart';

abstract class AdminGetCompaniesEvent extends Equatable {
  const AdminGetCompaniesEvent();
}

class AdminGetCompaniesListEvent extends AdminGetCompaniesEvent {
  final int page;

  const AdminGetCompaniesListEvent({required this.page});

  @override
  List<Object> get props => [page];
}
