import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/models/login_model.dart';

abstract class LoginDatasource {
  Future login(LoginModel adminLogin);
}
