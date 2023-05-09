import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/infra/models/change_image_model.dart';

abstract class ChangeImageDatasource {
  Future changeImage(ChangeImageModel params);
}
