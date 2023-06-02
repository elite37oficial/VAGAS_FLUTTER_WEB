import 'package:vagas_flutter_web/src/shared/utils/environment_config/environment_config.dart';

abstract class Endpoints {
  static String baseURL = EnvironmentFactory().getEnvironment().baseURL;

  static String login = "$baseURL/login";

  static String users = "$baseURL/users";
  static String jobs = "$baseURL/jobs";
  static String jobsById(String jobId) => "$baseURL/jobs/id/$jobId";
  static String companies = "$baseURL/companies-list";

  static String forgotPassword = "$baseURL/reset-password-email";
  static String resetPassword = "$baseURL/reset-password";

  static String getJobsByRecruiterId(String userId) =>
      "$baseURL/jobs?created_by=$userId";
  static String pageJobs(int page, String userId) =>
      "$baseURL/jobs/v2?page=$page&limit=10&created_by=$userId";
  static String companyImage = "$baseURL/companies-image";

  static String pageCompanies(int page) =>
      "$baseURL/companies?page=$page&limit=10";

  static String getJobById(String jobId) => "$baseURL/jobs/id/$jobId";
  static String getUserById(String userId) => "$baseURL/users/id/$userId";
  static String getCompanyImageById(String? companyId) =>
      "$baseURL/companies-image/id/$companyId";
  static String getCompanyById(String companyId) =>
      "$baseURL/companies/id/$companyId";
}
