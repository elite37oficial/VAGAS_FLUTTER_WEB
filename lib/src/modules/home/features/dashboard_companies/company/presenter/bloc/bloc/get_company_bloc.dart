import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/domain/usecases/get_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/presenter/bloc/events/get_company_event.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/presenter/bloc/states/get_company_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetCompanyBloc extends Bloc<GetCompanyEvent, GetCompanyStates> {
  final GetCompanyUsecase usecase;
  GetCompanyBloc({required this.usecase}) : super(GetCompanyInitialState()) {
    on<GetCompanyListEvent>(getCompany);
  }

  void getCompany(
    GetCompanyEvent event,
    Emitter<GetCompanyStates> emitter,
  ) async {
    emitter(GetCompanyLoadingState());

    var result = await usecase(NoParams());

    result.fold(
      (Failure failure) => emitter(
          GetCompanyErrorState(message: failure.props.first.toString())),
      (List<CompanyEntity> success) =>
          emitter(GetCompanySuccessState(listCompanies: success)),
    );
  }
}
