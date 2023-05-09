import 'package:vagas_flutter_web/src/shared/utils/environment_config/environment_config.dart';

abstract class Endpoints {
  static String baseURL = EnvironmentFactory().getEnvironment().baseURL;

  static String login = "$baseURL/login";

  static String users = "$baseURL/users";
  static String jobs = "$baseURL/jobs";
  static String companies = "$baseURL/companies";

  static String forgotPassword = "$baseURL/forgotPassword";
  static String resetPassword = "$baseURL/resetPassword";

  static String getJobsByRecruiterId(String userId) =>
      "$baseURL/jobs?created_by=$userId";
  static String pageJobs(int page, String userId) =>
      "$baseURL/jobs?page=$page&limit=10&created_by=$userId";

  static String getJobById(String jobId) => "$baseURL/jobs/id/$jobId";
  static String getUserById(String userId) => "$baseURL/users/id/$userId";
  static String getCompanyImageById(String companyId) =>
      "$baseURL/companies-image/id/$companyId";
}
