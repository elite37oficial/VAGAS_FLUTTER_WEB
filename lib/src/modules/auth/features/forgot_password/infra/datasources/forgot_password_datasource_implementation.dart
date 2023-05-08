import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/infra/datasources/forgot_password_datasource.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class ForgotPasswordDatasourceImplementation
    implements ForgotPasswordDatasource {
  final AppRequester requester;

  const ForgotPasswordDatasourceImplementation({required this.requester});

  @override
  Future forgotPassword(String email) async {
    // return await requester.post(
    //   url: Endpoints.login,
    //   body: {"email": email},
    //   fromJson: (value) {},
    // );
    return "teste";
  }
}
