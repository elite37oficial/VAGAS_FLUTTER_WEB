import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/domain/entities/create_company_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/domain/usecases/create_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/presenter/blocs/events/create_company_event.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/presenter/blocs/states/create_company_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class CreateCompanyBloc extends Bloc<CreateCompanyEvent, CreateCompanyStates> {
  final CreateCompanyUsecase usecase;
  CreateCompanyBloc({required this.usecase})
      : super(CreateCompanyInitialState()) {
    on<DoCreateCompanyEvent>(createCompany);
  }

  void createCompany(
    CreateCompanyEvent event,
    Emitter<CreateCompanyStates> emitter,
  ) async {
    emitter(CreateCompanyLoadingState());

    var result = await usecase(event.props.first as CreateCompanyEntity);

    result.fold(
      (Failure failure) => emitter(
          CreateCompanyErrorState(message: failure.props.first.toString())),
      (CompanyEntity success) =>
          emitter(CreateCompanySuccessState(company: success)),
    );
  }
}