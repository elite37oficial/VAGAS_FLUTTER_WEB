import 'package:equatable/equatable.dart';

import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/domain/entities/create_company_entity.dart';

abstract class CreateCompanyEvent extends Equatable {
  const CreateCompanyEvent();
}

class DoCreateCompanyEvent extends CreateCompanyEvent {
  final CreateCompanyEntity createCompanyData;

  const DoCreateCompanyEvent({required this.createCompanyData});

  @override
  List<CreateCompanyEntity> get props => [createCompanyData];
}
