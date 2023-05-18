import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/domain/entities/get_company_image_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/domain/usecases/get_company_image_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/presenter/bloc/events/get_company_image_event.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/presenter/bloc/states/get_company_image_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetCompanyImageBloc
    extends Bloc<GetCompanyImageEvent, GetCompanyImageStates> {
  final GetCompanyImageUsecase usecase;
  GetCompanyImageBloc({required this.usecase})
      : super(GetCompanyImageInitialState()) {
    on<DoGetCompanyImageEvent>(getCompanyImage);
  }

  void getCompanyImage(
    DoGetCompanyImageEvent event,
    Emitter<GetCompanyImageStates> emitter,
  ) async {
    emitter(GetCompanyImageLoadingState());

    var result = await usecase(NoParams());

    result.fold(
      (Failure failure) => emitter(
          GetCompanyImageErrorState(message: failure.props.first.toString())),
      (GetCompanyImageEntity success) =>
          emitter(GetCompanyImageSuccessState(getCompanyImage: success)),
    );
  }
}
