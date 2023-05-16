import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/entities/get_company_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/usecases/get_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/presenter/blocs/events/get_company_events.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/presenter/blocs/states/get_company_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class GetCompanyBloc extends Bloc<GetCompanyEvent, GetCompanyStates> {
  final GetCompanyUsecase usecase;
  GetCompanyBloc({required this.usecase}) : super(GetCompanyInitialState()) {
    on<DoGetCompanyEvent>(getCompany);
  }

  void getCompany(
    DoGetCompanyEvent event,
    Emitter<GetCompanyStates> emitter,
  ) async {
    emitter(GetCompanyLoadingState());
    String id = event.id;
    var result = await usecase(id);

    result.fold(
      (Failure failure) => emitter(
          GetCompanyErrorState(message: failure.props.first.toString())),
      (GetCompanyEntity success) =>
          emitter(GetCompanySuccessState(getCompany: success)),
    );
  }
}
