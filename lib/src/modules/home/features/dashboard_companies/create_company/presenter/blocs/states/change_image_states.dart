import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/domain/entities/change_image_entity.dart';

abstract class ChangeImageStates {}

class ChangeImageInitialState extends ChangeImageStates {}

class ChangeImageLoadingState extends ChangeImageStates {}

class ChangeImageSuccessState extends ChangeImageStates {
  final ChangeImageEntity response;

  ChangeImageSuccessState({required this.response});
}

class ChangeImageErrorState extends ChangeImageStates {
  final String message;

  ChangeImageErrorState({required this.message});
}
