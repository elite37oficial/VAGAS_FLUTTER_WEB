import 'package:dio/dio.dart';

abstract class AppRequester {
  Future<Response?>? get(
      {required String url, required Function(dynamic p1) fromJson});
  Future<Response?>? post(
      {required String url, body, required Function(dynamic p1) fromJson});
  Future<Response?>? put(
      {required String url, body, required Function(dynamic p1) fromJson});
  Future<Response?>? delete(
      {required String url, body, required Function(dynamic p1) fromJson});
}
