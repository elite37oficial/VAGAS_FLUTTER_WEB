import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/infra/datasources/admin_login_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/infra/models/admin_login_model.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/infra/models/admin_user_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class AdminLoginDatasourceImplementation implements AdminLoginDatasource {
  final AppRequester requester;

  AdminLoginDatasourceImplementation({required this.requester});

  @override
  Future login(AdminLoginModel adminLogin) async {
    return await requester.post(
      url: Endpoints.loginAdmin,
      body: adminLogin.toMap(),
      fromJson: (value) => AdminUserModel.fromMap(value),
    );
  }
}
