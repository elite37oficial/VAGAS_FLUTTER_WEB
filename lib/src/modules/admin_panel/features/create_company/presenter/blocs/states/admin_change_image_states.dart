import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/entities/admin_change_image_entity.dart';

abstract class AdminChangeImageStates {}

class AdminChangeImageInitialState extends AdminChangeImageStates {}

class AdminChangeImageLoadingState extends AdminChangeImageStates {}

class AdminChangeImageSuccessState extends AdminChangeImageStates {
  final AdminChangeImageEntity response;

  AdminChangeImageSuccessState({required this.response});
}

class AdminChangeImageErrorState extends AdminChangeImageStates {
  final String message;

  AdminChangeImageErrorState({required this.message});
}
