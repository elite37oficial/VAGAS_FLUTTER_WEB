import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/models/register_model.dart';

abstract class RegisterDatasource {
  Future register(RegisterModel registerModel);
}
