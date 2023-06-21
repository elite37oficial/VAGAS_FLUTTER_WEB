import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/entities/admin_create_company_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/usecases/admin_create_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/presenter/blocs/events/admin_create_company_event.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/presenter/blocs/states/admin_create_company_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class AdminCreateCompanyBloc
    extends Bloc<AdminCreateCompanyEvent, AdminCreateCompanyStates> {
  final AdminCreateCompanyUsecase usecase;
  AdminCreateCompanyBloc({required this.usecase})
      : super(AdminCreateCompanyInitialState()) {
    on<DoAdminCreateCompanyEvent>(createCompany);
  }

  void createCompany(
    DoAdminCreateCompanyEvent event,
    Emitter<AdminCreateCompanyStates> emitter,
  ) async {
    emitter(AdminCreateCompanyLoadingState());

    AdminCreateCompanyEntity createCompanyEntity = AdminCreateCompanyEntity(
      name: event.name,
      location: event.location,
      description: event.description,
    );

    var result = await usecase(createCompanyEntity);
    result.fold(
        (Failure failure) => emitter(AdminCreateCompanyErrorState(
            message: failure.props.first.toString())),
        (AdminCreateCompanyEntity success) {
      emitter(AdminCreateCompanySuccessState(company: success));
    });
  }
}
