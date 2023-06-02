import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/entities/edit_image_entity.dart';

abstract class EditImageStates {}

class EditImageInitialState extends EditImageStates {}

class EditImageLoadingState extends EditImageStates {}

class EditImageSuccessState extends EditImageStates {
  final EditImageEntity response;

  EditImageSuccessState({required this.response});
}

class EditImageErrorState extends EditImageStates {
  final String message;

  EditImageErrorState({required this.message});
}
