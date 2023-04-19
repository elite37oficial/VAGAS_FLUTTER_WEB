import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/models/get_my_self_model.dart';

abstract class GetMySelfDatasource {
  Future getMySelf(GetMySelfModel getMySelfModel);
}
