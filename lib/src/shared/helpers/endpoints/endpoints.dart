import 'package:vagas_flutter_web/src/shared/utils/environment_congi/environment_config.dart';

abstract class Endpoints {
  static String baseURL = EnvironmentFactory().getEnvironment().baseURL;

  static String login = "$baseURL/api/auth/login";
  static String loginAdmin = "$baseURL/api/admin/login";
  static String adminGetUsers = "$baseURL/api/admin/getUsers";

  static String register = "$baseURL/api/auth/register";

  static String dashboardGetJobs = "$baseURL/api/jobs/get_jobs";

  static String dashboardGetCompanies = "$baseURL/api/companies/get_companies";

  static String dashboardCreateCompanies =
      "$baseURL/api/companies/post_companies";

  static String fetchJobsById(String jobId) =>
      "$baseURL/api/jobs?jobId=$jobId}";
}
