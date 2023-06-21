import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/entities/admin_get_all_companies_response_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/usecases/admin_get_all_companies_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/presenter/blocs/events/admin_get_all_companies_events.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/presenter/blocs/states/admin_get_all_companies_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class AdminGetAllCompaniesBloc
    extends Bloc<AdminGetAllCompaniesEvent, AdminGetAllCompaniesStates> {
  final AdminGetAllCompaniesUsecase usecase;
  AdminGetAllCompaniesBloc({required this.usecase})
      : super(AdminGetAllCompaniesStatesInitialState()) {
    on<DoAdminGetAllCompaniesEvent>(getAllCompanies);
  }

  void getAllCompanies(
    DoAdminGetAllCompaniesEvent event,
    Emitter<AdminGetAllCompaniesStates> emitter,
  ) async {
    emitter(AdminGetAllCompaniesStatesLoadingState());

    var result = await usecase(NoParams());

    result.fold(
      (Failure failure) => emitter(AdminGetAllCompaniesErrorState(
          message: failure.props.first.toString())),
      (AdminGetAllCompaniesResponseEntity success) => emitter(
          AdminGetAllCompaniesSuccessState(
              listCompanies: success.listCompanies)),
    );
  }
}
