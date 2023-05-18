import 'package:equatable/equatable.dart';

abstract class GetCompanyImageEvent extends Equatable {
  const GetCompanyImageEvent();
}

class DoGetCompanyImageEvent extends GetCompanyImageEvent {
  final String companyId;

  const DoGetCompanyImageEvent({
    required this.companyId,
  });

  @override
  List<Object?> get props => [companyId];
}
