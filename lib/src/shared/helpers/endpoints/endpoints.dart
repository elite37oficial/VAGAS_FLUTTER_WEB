import 'package:vagas_flutter_web/src/shared/utils/environment_congi/environment_config.dart';

abstract class Endpoints {
  static String baseURL = EnvironmentFactory().getEnvironment().baseURL;

  static String login = "$baseURL/api/auth/login";
  static String loginAdmin = "$baseURL/api/admin/login";
  static String adminGetUsers = "$baseURL/api/admin/getUsers";

  static String fetchJobsById(String jobId) =>
      "$baseURL/api/jobs?jobId=$jobId}";
}
