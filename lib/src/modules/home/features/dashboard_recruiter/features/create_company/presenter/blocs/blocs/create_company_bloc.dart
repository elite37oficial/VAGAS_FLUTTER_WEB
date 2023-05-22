import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/domain/entities/create_company_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/domain/usecases/create_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/presenter/blocs/blocs/change_image_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/presenter/blocs/events/change_image_event.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/presenter/blocs/events/create_company_event.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/presenter/blocs/states/create_company_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class CreateCompanyBloc extends Bloc<CreateCompanyEvent, CreateCompanyStates> {
  final CreateCompanyUsecase usecase;
  CreateCompanyBloc({required this.usecase})
      : super(CreateCompanyInitialState()) {
    on<DoCreateCompanyEvent>(createCompany);
  }

  void createCompany(
    DoCreateCompanyEvent event,
    Emitter<CreateCompanyStates> emitter,
  ) async {
    emitter(CreateCompanyLoadingState());

    CreateCompanyEntity createCompanyEntity = CreateCompanyEntity(
      name: event.name,
      location: event.location,
      description: event.description,
    );

    var result = await usecase(createCompanyEntity);
    result.fold(
        (Failure failure) => emitter(
            CreateCompanyErrorState(message: failure.props.first.toString())),
        (CreateCompanyEntity success) {
      emitter(CreateCompanySuccessState(company: success));
    });
  }
}
