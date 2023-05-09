import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/entities/get_all_companies_response_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/usecases/get_all_companies_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

part '../states/get_all_companies_states.dart';
part '../events/get_all_companies_events.dart';

class GetAllCompaniesBloc
    extends Bloc<GetAllCompaniesEvent, GetAllCompaniesStates> {
  final GetAllCompaniesUsecase usecase;
  GetAllCompaniesBloc({required this.usecase})
      : super(GetAllCompaniesStatesInitialState()) {
    on<DoGetAllCompaniesEvent>(getAllCompanies);
  }

  void getAllCompanies(
    DoGetAllCompaniesEvent event,
    Emitter<GetAllCompaniesStates> emitter,
  ) async {
    emitter(GetAllCompaniesStatesLoadingState());

    var result = await usecase(NoParams());

    result.fold(
      (Failure failure) => emitter(
          GetAllCompaniesErrorState(message: failure.props.first.toString())),
      (GetAllCompaniesResponseEntity success) => emitter(
          GetAllCompaniesSuccessState(listCompanies: success.listCompanies)),
    );
  }
}
