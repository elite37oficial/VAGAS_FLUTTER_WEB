import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/datasources/register_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/models/register_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class RegisterDatasourceImplementation implements RegisterDatasource {
  final AppRequester requester;

  RegisterDatasourceImplementation({required this.requester});

  @override
  Future register(RegisterModel registerModel) async {
    return await requester.post(
      url: Endpoints.users,
      body: registerModel.toMap(),
      fromJson: (value) {},
    );
  }
}
