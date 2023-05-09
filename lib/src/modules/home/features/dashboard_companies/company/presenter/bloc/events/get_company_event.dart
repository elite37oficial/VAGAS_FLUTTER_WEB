import 'package:equatable/equatable.dart';

abstract class GetCompaniesEvent extends Equatable {
  const GetCompaniesEvent();
}

class DoGetCompaniesEvent extends GetCompaniesEvent {
  @override
  List<Object> get props => [];
}
