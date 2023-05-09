import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/infra/datasources/reset_password_datasource.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class ResetPasswordDatasourceImplementation implements ResetPasswordDatasource {
  final AppRequester requester;

  const ResetPasswordDatasourceImplementation({required this.requester});

  @override
  Future resetPassword(String email) async {
    // return await requester.post(
    //   url: Endpoints.resetPassword,
    //   body: {"email": email},
    //   fromJson: (value) {},
    // );
    return "teste";
  }
}
