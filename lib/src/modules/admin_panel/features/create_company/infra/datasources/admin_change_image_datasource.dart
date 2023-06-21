import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/models/admin_change_image_model.dart';

abstract class AdminChangeImageDatasource {
  Future changeImage(AdminChangeImageModel params);
}
