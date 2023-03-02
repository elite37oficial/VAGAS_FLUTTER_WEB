abstract class AppRequester {
  Future get({required String url, required Function(dynamic p1) fromJson});
  Future post(
      {required String url, body, required Function(dynamic p1) fromJson});
  Future put(
      {required String url, body, required Function(dynamic p1) fromJson});
  Future delete(
      {required String url, body, required Function(dynamic p1) fromJson});
}
