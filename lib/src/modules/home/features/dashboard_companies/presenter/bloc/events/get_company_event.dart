import 'package:equatable/equatable.dart';

abstract class GetCompanyEvent extends Equatable {
  const GetCompanyEvent();
}

class GetCompanyListEvent extends GetCompanyEvent {
  @override
  List<Object> get props => [];
}
