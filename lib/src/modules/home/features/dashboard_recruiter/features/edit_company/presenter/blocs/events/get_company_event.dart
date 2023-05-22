import 'package:equatable/equatable.dart';

abstract class GetCompanyEvent extends Equatable {
  const GetCompanyEvent();
}

class DoGetCompanyEvent extends GetCompanyEvent {
  final String id;

  const DoGetCompanyEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
