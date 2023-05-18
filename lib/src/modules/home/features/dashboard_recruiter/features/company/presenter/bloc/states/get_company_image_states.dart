import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/domain/entities/get_company_image_entity.dart';

abstract class GetCompanyImageStates {}

class GetCompanyImageInitialState extends GetCompanyImageStates {}

class GetCompanyImageLoadingState extends GetCompanyImageStates {}

class GetCompanyImageSuccessState extends GetCompanyImageStates {
  final GetCompanyImageEntity getCompanyImage;

  GetCompanyImageSuccessState({required this.getCompanyImage});
}

class GetCompanyImageErrorState extends GetCompanyImageStates {
  final String message;

  GetCompanyImageErrorState({required this.message});
}
