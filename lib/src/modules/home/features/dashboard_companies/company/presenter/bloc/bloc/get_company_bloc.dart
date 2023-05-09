import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/domain/entities/get_companies_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/domain/usecases/get_companies_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/presenter/bloc/events/get_company_event.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/presenter/bloc/states/get_company_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetCompaniesBloc extends Bloc<GetCompaniesEvent, GetCompaniesStates> {
  final GetCompaniesUsecase usecase;
  GetCompaniesBloc({required this.usecase})
      : super(GetCompaniesInitialState()) {
    on<DoGetCompaniesEvent>(getCompanies);
  }

  void getCompanies(
    DoGetCompaniesEvent event,
    Emitter<GetCompaniesStates> emitter,
  ) async {
    emitter(GetCompaniesLoadingState());

    var result = await usecase(NoParams());

    result.fold(
      (Failure failure) => emitter(
          GetCompaniesErrorState(message: failure.props.first.toString())),
      (GetCompaniesEntity success) => emitter(
          GetCompaniesSuccessState(listCompanies: success.listCompanies)),
    );
  }
}
