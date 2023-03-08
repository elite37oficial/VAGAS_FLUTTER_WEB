import 'package:vagas_flutter_web/src/modules/auth/admin_login/infra/models/admin_login_model.dart';

abstract class AdminLoginDatasource {
  Future login(AdminLoginModel adminLogin);
}
