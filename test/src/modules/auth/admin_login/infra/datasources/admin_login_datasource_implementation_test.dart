import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/infra/datasources/admin_login_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/infra/datasources/admin_login_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/infra/models/admin_login_model.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/infra/models/admin_user_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class AppRequesterMock extends Mock implements AppRequester {}

main() {
  late AppRequester requester;
  late AdminLoginDatasource datasource;

  setUp(() {
    requester = AppRequesterMock();
    datasource = AdminLoginDatasourceImplementation(requester: requester);
  });

  AdminLoginModel loginModel = const AdminLoginModel(
    email: "teste@email.com",
    password: "password",
  );

  AdminUserModel adminUser = AdminUserModel(
    userId: "123",
    username: "teste",
    email: "teste@email.com",
    createdAt: DateTime(2017, 9, 7),
  );

  test("Should call the login with correct Method", () async {
    when(() async => await requester.post(
          url: Endpoints.loginAdmin,
          body: loginModel.toMap(),
          fromJson: (value) => AdminUserModel.fromMap(value),
        )).thenAnswer(
      (_) async => Response(
        data: AdminUserModel(
          userId: "123",
          email: "teste@email.com",
          username: "username",
          createdAt: DateTime(2017, 9, 7),
        ),
        statusCode: 200,
        requestOptions: RequestOptions(data: loginModel.toMap()),
      ),
    );

    await datasource.login(loginModel);
  });

  test("Should return a AdminUserModel when is successful", () async {
    when(() async => await requester.post(
          url: Endpoints.loginAdmin,
          body: loginModel.toMap(),
          fromJson: (value) => AdminUserModel.fromMap(value),
        )).thenAnswer((_) async => Response(
          data: adminUser.toMap(),
          statusCode: 200,
          requestOptions: RequestOptions(data: loginModel.toMap()),
        ));

    AdminUserModel adminUserModelExpected = AdminUserModel(
      userId: "123",
      username: "teste",
      email: "teste@email.com",
      createdAt: DateTime(2017, 9, 7),
    );

    Response response = await datasource.login(loginModel);

    AdminUserModel result = AdminUserModel.fromMap(response.data);
    expect(result, adminUserModelExpected);
  });

  test(
      "Should throw a InvalidCredentialsException when the credentials are invalid",
      () async {
    var message = "Error! Invalid Credentials.";
    when(() => requester.post(
          url: any(named: "url"),
          body: loginModel,
          fromJson: (value) => AdminUserModel.fromMap(value),
        )).thenAnswer((_) async => Response(
          data: {"message": message},
          statusCode: 401,
          requestOptions: RequestOptions(
            data: loginModel.toMap(),
          ),
        ));

    final result = datasource.login(loginModel);

    expect(
        () => result, throwsA(InvalidCredentialsException(message: message)));
  });

  test("Should throw a BadRequestException when the the request is invalid",
      () async {
    var message = "Error! Bad Request.";
    when(() => requester.post(
          url: any(named: "url"),
          body: loginModel,
          fromJson: (value) => AdminUserModel.fromMap(value),
        )).thenAnswer((_) async => Response(
          data: {"message": message},
          statusCode: 400,
          requestOptions: RequestOptions(
            data: loginModel.toMap(),
          ),
        ));

    final result = datasource.login(loginModel);

    expect(() => result, throwsA(BadRequestException(message: message)));
  });

  test("Should throw a ServerException when the server unavaliable", () async {
    var message = "Server Error! Try Again Later.";
    when(() => requester.post(
          url: any(named: "url"),
          body: loginModel,
          fromJson: (value) => AdminUserModel.fromMap(value),
        )).thenAnswer((_) async => Response(
          data: {"message": message},
          statusCode: 500,
          requestOptions: RequestOptions(
            data: loginModel.toMap(),
          ),
        ));

    final result = datasource.login(loginModel);

    expect(() => result, throwsA(ServerException(message: message)));
  });
}
