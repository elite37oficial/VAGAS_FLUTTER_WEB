import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/datasources/get_users_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/datasources/get_users_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/models/get_users_response_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class AppRequesterMock extends Mock implements AppRequester {}

main() {
  late AppRequester requester;
  late GetUsersDatasource datasource;

  setUp(() {

    requester = AppRequesterMock();
    datasource = GetUsersDatasourceImplementation(requester: requester);
  });

  GetUsersResponseModel getUsersResponseModel = GetUsersResponseModel(
    listUsers: [],
  );

  test("Should call the login with correct Method", () async {
    when(() async => await requester.get(
          url: Endpoints.loginAdmin,
          fromJson: (value) => GetUsersResponseModel.fromMap(value),
        )).thenAnswer(
      (_) async => Response(
        data: getUsersResponseModel.toMap(),
        statusCode: 200,
        requestOptions: RequestOptions(),
      ),
    );

    await datasource.getUsers();
  });

  test("Should return a GetUsersResponseModel when is successful", () async {
    when(() async => await requester.get(
          url: Endpoints.loginAdmin,
          fromJson: (value) => GetUsersResponseModel.fromMap(value),
        )).thenAnswer((_) async => Response(
          data: getUsersResponseModel.toMap(),
          statusCode: 200,
          requestOptions: RequestOptions(),
        ));

    GetUsersResponseModel getUsersResponseModelExpected = GetUsersResponseModel(
      listUsers: [],
    );

    Response response = await datasource.getUsers();

    GetUsersResponseModel result = GetUsersResponseModel.fromMap(response.data);
    expect(result, getUsersResponseModelExpected);
  });

  test(
      "Should throw a InvalidCredentialsException when the credentials are invalid",
      () async {
    var message = "Error! Invalid Credentials.";
    when(() => requester.get(
          url: any(named: "url"),
          fromJson: (value) => GetUsersResponseModel.fromMap(value),
        )).thenAnswer((_) async => Response(
          data: {"message": message},
          statusCode: 401,
          requestOptions: RequestOptions(),
        ));

    final result = datasource.getUsers();

    expect(
        () => result, throwsA(InvalidCredentialsException(message: message)));
  });

  test("Should throw a BadRequestException when the the request is invalid",
      () async {
    var message = "Error! Bad Request.";
    when(() => requester.get(
          url: any(named: "url"),
          fromJson: (value) => GetUsersResponseModel.fromMap(value),
        )).thenAnswer((_) async => Response(
          data: {"message": message},
          statusCode: 400,
          requestOptions: RequestOptions(),
        ));

    final result = datasource.getUsers();

    expect(() => result, throwsA(BadRequestException(message: message)));
  });

  test("Should throw a ServerException when the server unavaliable", () async {
    var message = "Server Error! Try Again Later.";
    when(() => requester.get(
          url: any(named: "url"),
          fromJson: (value) => GetUsersResponseModel.fromMap(value),
        )).thenAnswer((_) async => Response(
          data: {"message": message},
          statusCode: 500,
          requestOptions: RequestOptions(),
        ));

    final result = datasource.getUsers();

    expect(() => result, throwsA(ServerException(message: message)));
  });
}
