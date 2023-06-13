import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/domain/entities/admin_get_companies_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/domain/usecases/admin_get_companies_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/presenter/bloc/events/admin_get_companies_event.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/presenter/bloc/states/admin_get_companies_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class AdminGetCompaniesBloc
    extends Bloc<AdminGetCompaniesEvent, AdminGetCompaniesStates> {
  final AdminGetCompaniesUsecase usecase;
  AdminGetCompaniesBloc({required this.usecase})
      : super(AdminGetCompaniesInitialState()) {
    on<AdminGetCompaniesListEvent>(adminGetCompanies);
  }

  void adminGetCompanies(
    AdminGetCompaniesListEvent event,
    Emitter<AdminGetCompaniesStates> emitter,
  ) async {
    emitter(AdminGetCompaniesLoadingState());

    var result = await usecase(event.page);

    result.fold(
        (Failure failure) => emitter(AdminGetCompaniesErrorState(
            message: failure.props.first.toString())),
        (AdminGetCompaniesEntity success) {
      emitter(AdminGetCompaniesSuccessState(listCompanies: success));
    });
  }
}
