import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/infra/models/reset_password_model.dart';

abstract class ResetPasswordDatasource {
  Future resetPassword(ResetPasswordModel resetPassword);
}
