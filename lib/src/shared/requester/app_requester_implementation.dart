import 'dart:convert' as convert;
import 'package:dio/dio.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/debug_helper.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';
import 'package:vagas_flutter_web/src/shared/requester/interceptors/header_interceptor.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';

class AppRequesterImplementation implements AppRequester {
  List<Interceptor> _customIntecerptors = [];

  static final AppRequesterImplementation _singleton =
      AppRequesterImplementation._internal();

  factory AppRequesterImplementation({
    List<Interceptor>? customInterceptors,
  }) {
    if (customInterceptors != null) {
      _singleton._customIntecerptors = customInterceptors;
    }

    return _singleton;
  }

  AppRequesterImplementation._internal();

  Future<void> _addToken(Dio dio) async {
    final accessToken =
        await SecureStorageManager.readData(StorageKeys.accessToken);

    if (accessToken != null) {
      dio.options.headers.addAll({'Authorization': 'Bearer $accessToken'});
    }
  }

  Dio _setOptions(String url) {
    var dio = Dio();
    _addToken(dio);
    dio.interceptors.addAll(_customIntecerptors);

    dio.interceptors.add(HeaderInterceptor());

    if (debugMode) {
      dio.interceptors.add(PrettyDioLogger(
        request: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        requestBody: true,
        error: true,
        maxWidth: 90,
        compact: true,
      ));
    }

    dio.options.baseUrl = url;
    return dio;
  }

  @override
  Future delete(
      {required String url,
      body,
      required Function(dynamic p1) fromJson}) async {
    return _invokeRequest(
      url: url,
      fromJson: fromJson,
      invokeDio: (dio) async {
        return await dio.delete(url, data: body);
      },
    );
  }

  @override
  Future get(
      {required String url,
      body,
      required Function(dynamic p1) fromJson}) async {
    return _invokeRequest(
      url: url,
      fromJson: fromJson,
      invokeDio: (dio) async {
        return await dio.get(url);
      },
    );
  }

  @override
  Future post(
      {required String url,
      body,
      required Function(dynamic p1) fromJson}) async {
    return _invokeRequest(
      url: url,
      fromJson: fromJson,
      invokeDio: (dio) async {
        return await dio.post(url, data: body);
      },
    );
  }

  @override
  Future put(
      {required String url,
      body,
      required Function(dynamic p1) fromJson}) async {
    return _invokeRequest(
      url: url,
      fromJson: fromJson,
      invokeDio: (dio) async {
        return await dio.put(url, data: body);
      },
    );
  }

  Future _invokeRequest({
    required String url,
    required Function(dynamic p1) fromJson,
    required Future<Response<dynamic>?> Function(Dio) invokeDio,
  }) async {
    var dio = _setOptions(url);
    await _addToken(dio);

    late Response<dynamic>? response;

    response = await invokeDio(dio);

    return fromJson(response?.data);
  }

  static String handleErrorAndGetMessage(Object e, {String? message}) {
    String msg;
    if (message == null || message.isEmpty) {
      msg = "Falha na conexão com o servidor. ";
    } else {
      msg = message;
    }
    return "$msg (${getErrorCode(e)})";
  }

  static String handleErrorAndGetMessageFromException(Object e) {
    String msg;
    if (e is RequestException) {
      msg = convert.utf8.decode(getExceptionMessage(e)!.codeUnits);
    } else {
      msg = "Falha na conexão com o servidor.";
    }
    return msg;
  }

  static String getErrorCode(Object e) {
    String code;
    if (e is RequestException) {
      code = e.statusCode.toString();
    } else if (e is Exception) {
      code = "-1";
    } else {
      code = "-999";
    }
    return code;
  }

  static String? getExceptionMessage(Exception e) {
    return (e as RequestException).message;
  }
}
