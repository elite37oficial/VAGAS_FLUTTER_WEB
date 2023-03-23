import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/datasources/register_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/datasources/register_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/models/register_model.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/models/register_user_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class AppRequesterMock extends Mock implements AppRequester {}

main() {
  late AppRequester requester;
  late RegisterDatasource datasource;

  setUp(() {
    requester = AppRequesterMock();
    datasource = RegisterDatasourceImplementation(requester: requester);
  });

  RegisterModel registerModel = const RegisterModel(
    company: "company",
    email: "teste@email.com",
    password: "password",
  );

  RegisterUserModel registerUser = RegisterUserModel(
    userId: "123",
    company: "company",
    username: "username",
    email: "teste@email.com",
    createdAt: DateTime(2020, 02),
  );

  test("Should call the register with correct Method", () async {
    when(() async => await requester.post(
          url: Endpoints.register,
          body: registerModel.toMap(),
          fromJson: (value) => RegisterUserModel.fromMap(value),
        )).thenAnswer((_) async => Response(
          data: RegisterUserModel(
            userId: "123",
            company: "company",
            username: "username",
            email: "teste@email.com",
            createdAt: DateTime(2020, 02),
          ),
          statusCode: 200,
          requestOptions: RequestOptions(data: registerUser.toMap()),
        ));

    await datasource.register(registerModel);
  });

  test("Should return a RegisterUserModel when is successful", () async {
    when(() async => await requester.post(
          url: Endpoints.register,
          body: registerModel.toMap(),
          fromJson: (value) => RegisterUserModel.fromMap(value),
        )).thenAnswer((_) async => Response(
          data: registerUser.toMap(),
          statusCode: 200,
          requestOptions: RequestOptions(data: registerModel.toMap()),
        ));

    RegisterUserModel registerUserModelExpected = RegisterUserModel(
      userId: "123",
      company: "company",
      username: "username",
      email: "teste@email.com",
      createdAt: DateTime(2020, 02),
    );

    Response response = await datasource.register(registerModel);

    RegisterUserModel result = RegisterUserModel.fromMap(response.data);
    expect(result, registerUserModelExpected);
  });

  test(
      "Should throw a InvalidCredentialsException when the credentials are invalid",
      () async {
    var message = "Error! Invalid Credentials.";
    when(() => requester.post(
          url: any(named: "url"),
          body: registerModel,
          fromJson: (value) => RegisterUserModel.fromMap(value),
        )).thenAnswer((_) async => Response(
          data: {"message": message},
          statusCode: 401,
          requestOptions: RequestOptions(
            data: {"message": message},
          ),
        ));

    final result = datasource.register(registerModel);

    expect(
        () => result, throwsA(InvalidCredentialsException(message: message)));
  });

  test("Should throw a BadRequestException when the the request is invalid",
      () async {
    var message = "Error! Bad Request.";
    when(() => requester.post(
          url: any(named: "url"),
          body: registerModel,
          fromJson: (value) => RegisterUserModel.fromMap(value),
        )).thenAnswer((_) async => Response(
          data: {"message": message},
          statusCode: 400,
          requestOptions: RequestOptions(
            data: {"message": message},
          ),
        ));

    final result = datasource.register(registerModel);

    expect(() => result, throwsA(BadRequestException(message: message)));
  });

  test("Should throw a ServerException when the server unavaliable", () async {
    var message = "Server Error! Try Again Later.";
    when(() => requester.post(
          url: any(named: "url"),
          body: registerModel,
          fromJson: (value) => RegisterUserModel.fromMap(value),
        )).thenAnswer((_) async => Response(
          data: {"message": message},
          statusCode: 500,
          requestOptions: RequestOptions(
            data: {"message": message},
          ),
        ));

    final result = datasource.register(registerModel);

    expect(() => result, throwsA(ServerException(message: message)));
  });
}
