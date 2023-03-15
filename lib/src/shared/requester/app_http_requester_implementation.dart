import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vagas_flutter_web/src/shared/helpers/generics/debug_helper.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_http_requester.dart';

class AppHttpRequesterImplementation implements AppHttpRequester {
  ///Default success code range
  static const int minDefaultSuccess = 200;
  static const int maxDefaultSuccess = 300;

  AppHttpRequesterImplementation();

  Future<T> _requestV1<T>(
      {String? url,
      Map? header,
      dynamic body,
      T Function(Map<String, dynamic>)? fromJson,
      Future<http.Response> Function()? response}) async {
    int timeItStarted = DateTime.now().millisecondsSinceEpoch;
    if (debugMode) print("Requester - URL: $url");
    if (debugMode) print("Requester - header: $header");
    if (body != null) if (debugMode) print("Requester - body: $body");
    http.Response _response = await response!();
    int timeItTook = DateTime.now().millisecondsSinceEpoch - timeItStarted;
    if (debugMode) print("Requester - END POST IN ${timeItTook}ms - $url");
    if (debugMode) {
      print("Requester - RESPONSE - statusCode: ${_response.statusCode}");
      print("body: ${_response.body}");
    }
    _verifyStatusCode(_response);
    return fromJson!(json.decode(_response.body));
  }

  ///[Post] method which calls [request] using [http.post]
  @override
  Future<T> post<T>({
    String? url,
    Map<String, String>? header,
    dynamic body,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    if (debugMode) print("Requester - Method: POST");
    return await _requestV1(
        url: url,
        header: header,
        body: body,
        fromJson: fromJson,
        response: () {
          return http.post(Uri.parse(url!),
              headers: header, body: _parseBody(body));
        });
  }

  ///[Put] method which calls [request] using [http.put]
  @override
  Future<T> put<T>({
    String? url,
    Map<String, String>? header,
    dynamic body,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    if (debugMode) print("Requester - Method: PUT");
    return await _requestV1(
        url: url,
        header: header,
        body: body,
        fromJson: fromJson,
        response: () {
          return http.put(Uri.parse(url!),
              headers: header, body: _parseBody(body));
        });
  }

  ///[Get] method which calls [request] using [http.get]
  @override
  Future<T> get<T>({
    String? url,
    Map<String, String>? header,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    if (debugMode) print("Requester - Method: GET");
    return await _requestV1(
        url: url,
        header: header,
        body: null,
        fromJson: fromJson,
        response: () {
          return http.get(Uri.parse(url!), headers: header);
        });
  }

  ///[Post] method which calls [request] using [http.delete]
  @override
  Future<T> delete<T>({
    String? url,
    Map<String, String>? header,
    T Function(Map<String, dynamic>)? fromJson,
    dynamic body,
  }) async {
    if (debugMode) print("Requester - Method: DELETE");
    return await _requestV1(
        url: url,
        header: header,
        body: null,
        fromJson: fromJson,
        response: () {
          return http.get(Uri.parse(url!), headers: header);
        });
  }

  ///Throws an [Exception] if the response is not successful
  void _verifyStatusCode(http.Response response) {
    if (!_isSuccessful(response)) {
      throw RequestException(
          statusCode: response.statusCode,
          message: response.body == null || response.body == ""
              ? "Erro ao processar solicitação"
              : response.body);
    }
  }

  ///Checks if [response] has a [successful] result
  ///based on the default success number [defaultSuccess] or the list which this class receives as a parameter
  bool _isSuccessful(http.Response response) {
    return response.statusCode >= minDefaultSuccess &&
        response.statusCode <= maxDefaultSuccess;
  }

  dynamic _parseBody(Map<String, dynamic>? body) {
    dynamic selectedBody;
    if (body != null) {
      selectedBody = jsonEncode(body);
    }
    return selectedBody;
  }

  static bool verifyExceptionCode(Exception e, int statusCode) {
    return (e is RequestException && e.statusCode == statusCode);
  }
}

class RequestException implements Exception {
  int? statusCode;
  String? message;

  RequestException({this.statusCode, this.message});
}
