import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/domain/entities/get_companies_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/domain/usecases/get_companies_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

part "../events/get_companies_event.dart";
part "../states/get_companies_states.dart";

class GetCompaniesBloc extends Bloc<GetCompaniesEvent, GetCompaniesStates> {
  final GetCompaniesUsecase usecase;
  GetCompaniesBloc({required this.usecase})
      : super(GetCompaniesInitialState()) {
    on<GetCompaniesListEvent>(getCompanies);
  }

  void getCompanies(
    GetCompaniesListEvent event,
    Emitter<GetCompaniesStates> emitter,
  ) async {
    emitter(GetCompaniesLoadingState());

    var result = await usecase(event.page);

    result.fold(
        (Failure failure) => emitter(
            GetCompaniesErrorState(message: failure.props.first.toString())),
        (GetCompaniesEntity success) {
      emitter(GetCompaniesSuccessState(listCompanies: success));
    });
  }
}
