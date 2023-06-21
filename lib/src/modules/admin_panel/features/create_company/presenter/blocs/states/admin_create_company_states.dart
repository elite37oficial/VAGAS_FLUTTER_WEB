import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/entities/admin_create_company_entity.dart';

abstract class AdminCreateCompanyStates {}

class AdminCreateCompanyInitialState extends AdminCreateCompanyStates {}

class AdminCreateCompanyLoadingState extends AdminCreateCompanyStates {}

class AdminCreateCompanySuccessState extends AdminCreateCompanyStates {
  final AdminCreateCompanyEntity company;

  AdminCreateCompanySuccessState({required this.company});
}

class AdminCreateCompanyErrorState extends AdminCreateCompanyStates {
  final String message;

  AdminCreateCompanyErrorState({required this.message});
}
