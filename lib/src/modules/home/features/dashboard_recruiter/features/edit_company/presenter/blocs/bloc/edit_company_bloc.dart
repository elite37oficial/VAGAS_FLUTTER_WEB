import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/entities/edit_company_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/usecases/edit_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/presenter/blocs/events/edit_company_event.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/presenter/blocs/states/edit_company_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class EditCompanyBloc extends Bloc<EditCompanyEvent, EditCompanyStates> {
  final EditCompanyUsecase usecase;
  EditCompanyBloc({required this.usecase}) : super(EditCompanyInitialState()) {
    on<DoEditCompanyEvent>(editCompany);
  }

  void editCompany(
    DoEditCompanyEvent event,
    Emitter<EditCompanyStates> emitter,
  ) async {
    emitter(EditCompanyLoadingState());

    EditCompanyEntity editCompanyEntity = EditCompanyEntity(
      id: event.id,
      name: event.name,
      location: event.location,
      description: event.description,
    );

    var result = await usecase(editCompanyEntity);
    result.fold(
        (Failure failure) => emitter(
            EditCompanyErrorState(message: failure.props.first.toString())),
        (bool success) {
      emitter(EditCompanySuccessState(editCompany: success));
    });
  }
}
