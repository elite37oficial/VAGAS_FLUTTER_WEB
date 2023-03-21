import 'package:vagas_flutter_web/src/modules/auth/login/infra/datasources/login_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/login/infra/models/login_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/user_model.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class LoginDatasourceImplementation implements LoginDatasource {
  final AppRequester requester;

  LoginDatasourceImplementation({required this.requester});

  @override
  Future login(LoginModel adminLogin) async {
    return await requester.post(
      url: Endpoints.login,
      body: adminLogin.toMap(),
      fromJson: (value) => UserModel.fromMap(value),
    );
  }
}
