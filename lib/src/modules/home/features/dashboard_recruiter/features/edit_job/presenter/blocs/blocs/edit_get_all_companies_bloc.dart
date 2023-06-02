import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/entities/edit_get_all_companies_response_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/usecases/edit_get_all_companies_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

part '../events/edit_get_all_companies_events.dart';
part '../states/edit_get_all_companies_states.dart';

class EditGetAllCompaniesBloc
    extends Bloc<EditGetAllCompaniesEvent, EditGetAllCompaniesStates> {
  final EditGetAllCompaniesUsecase usecase;
  EditGetAllCompaniesBloc({required this.usecase})
      : super(EditGetAllCompaniesStatesInitialState()) {
    on<DoEditGetAllCompaniesEvent>(getAllCompanies);
  }

  void getAllCompanies(
    DoEditGetAllCompaniesEvent event,
    Emitter<EditGetAllCompaniesStates> emitter,
  ) async {
    emitter(EditGetAllCompaniesStatesLoadingState());

    var result = await usecase(NoParams());

    result.fold(
      (Failure failure) => emitter(EditGetAllCompaniesErrorState(
          message: failure.props.first.toString())),
      (EditGetAllCompaniesResponseEntity success) => emitter(
          EditGetAllCompaniesSuccessState(
              listCompanies: success.listCompanies)),
    );
  }
}
