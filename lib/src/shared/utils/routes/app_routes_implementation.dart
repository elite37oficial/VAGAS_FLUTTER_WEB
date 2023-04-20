import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/usecases/get_users_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/datasources/get_users_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/repositories/get_users_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/blocs/blocs/get_users_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/pages/home_admin_panel_page.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/usecases/get_my_self_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/usecases/login_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/datasources/get_my_self_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/datasources/login_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/repositories/get_my_self_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/repositories/login_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/blocs/login_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/pages/login_page.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/usecases/register_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/datasources/register_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/repositories/register_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/presenter/blocs/blocs/register_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/presenter/pages/register_page.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/domain/usecases/create_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/domain/usecases/get_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/infra/datasources/create_company_datarouce_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/infra/datasources/get_company_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/infra/repositories/create_company_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/infra/repositories/get_company_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/bloc/bloc/create_company_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/bloc/bloc/get_company_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/pages/dashboard_companies_page.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/domain/usecases/get_job_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/infra/datasources/get_job_datasouce_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/infra/repositories/get_job_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/presenter/blocs/blocs/get_job_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/presenter/pages/dashboard_recruiter_page.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/services/auth_service.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

final authService = AuthService();

const String home = RouteKeys.companies;
// const String home = "${RouteKeys.auth}${RouteKeys.login}";

goToHome(BuildContext context) async {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    context.push(home);
  });
}

final appRoutesConfig = GoRouter(
  initialLocation: home,
  refreshListenable: authService,
  errorPageBuilder: (context, state) =>
      const NoTransitionPage(child: ErrorPage()),
  redirect: (context, state) {
    final isAuthenticated = authService.isAuthenticated;
    final isAuthRoute = state.subloc == RouteKeys.register;
    final isRegisterRoute =
        state.subloc == "${RouteKeys.auth}${RouteKeys.register}";
    final isLoginRoute = state.subloc == "${RouteKeys.auth}${RouteKeys.login}";

    if (!isAuthenticated && isLoginRoute) {
      return isAuthRoute ? null : "${RouteKeys.auth}${RouteKeys.login}";
    }
    if (!isAuthenticated && isRegisterRoute) {
      return isAuthRoute ? null : "${RouteKeys.auth}${RouteKeys.register}";
    }

    if (isAuthRoute) return RouteKeys.home;

    return null;
  },
  routes: [
    GoRoute(
        path: RouteKeys.init,
        name: RouteKeys.init,
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: Scaffold(),
          );
        }),
    GoRoute(
        path: RouteKeys.initial,
        name: RouteKeys.initial.replaceAll("/", ""),
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: Scaffold(),
          );
        }),
    GoRoute(
      path: RouteKeys.auth,
      name: RouteKeys.auth.replaceAll("/", ""),
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Scaffold(),
      ),
      routes: [
        GoRoute(
          path: RouteKeys.login.replaceAll("/", ""),
          name: RouteKeys.login.replaceAll("/", ""),
          pageBuilder: (context, state) {
            List<String> loginArgs =
                state.extra == null ? <String>[] : state.extra as List<String>;
            return NoTransitionPage(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<LoginBloc>(
                    create: (context) => LoginBloc(
                        getMySelfUsecase: GetMySelfUsecase(
                            repository: GetMySelfRepositoryImplementation(
                                datasource: GetMySelfDatasourceImplementation(
                          requester: AppRequesterImplementation(),
                        ))),
                        loginUsecase: LoginUsecase(
                          repository: LoginRepositoryImplementation(
                              datasource: LoginDatasourceImplementation(
                            requester: AppRequesterImplementation(),
                          )),
                        )),
                  ),
                ],
                child: LoginPage(args: loginArgs),
              ),
            );
          },
        ),
        GoRoute(
          path: RouteKeys.register.replaceAll("/", ""),
          name: RouteKeys.register.replaceAll("/", ""),
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<RegisterBloc>(
                    create: (context) => RegisterBloc(
                      usecase: RegisterUseCase(
                        repository: RegisterRepositoryImplementation(
                          datasource: RegisterDatasourceImplementation(
                            requester: AppRequesterImplementation(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                child: const RegisterPage(),
              ),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: RouteKeys.homeAdmin,
      name: RouteKeys.homeAdmin.replaceAll("/", ""),
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<GetUsersBloc>(
                create: (context) => GetUsersBloc(
                    usecase: GetUsersUsecase(
                  repository: GetUsersRepositoryImplementation(
                      datasource: GetUsersDatasourceImplementation(
                    requester: AppRequesterImplementation(),
                  )),
                )),
              ),
            ],
            child: const HomeAdminPanelPage(),
          ),
        );
      },
    ),
    GoRoute(
      path: RouteKeys.home,
      name: RouteKeys.home.replaceAll("/", ""),
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<GetJobBloc>(
                create: (context) => GetJobBloc(
                  usecase: GetJobUsecase(
                    repository: GetJobRepositoryImplementation(
                      datasource: GetJobDatasourceImplementation(
                        requester: AppRequesterImplementation(),
                      ),
                    ),
                  ),
                ),
              )
            ],
            child: const HomeRecruiterPage(),
          ),
        );
      },
    ),
    GoRoute(
      path: RouteKeys.companies,
      name: RouteKeys.companies.replaceAll("/", ""),
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CreateCompanyBloc(
                  usecase: CreateCompanyUsecase(
                    repository: CreateCompanyRepositoryImplementation(
                      datasource: CreateCompanyDatasourceImplementation(
                        requester: AppRequesterImplementation(),
                      ),
                    ),
                  ),
                ),
              ),
              BlocProvider<GetCompanyBloc>(
                create: (context) => GetCompanyBloc(
                  usecase: GetCompanyUsecase(
                    repository: GetCompanyRepositoryImplementation(
                      datasource: GetCompanyDatasourceImplementation(
                        requester: AppRequesterImplementation(),
                      ),
                    ),
                  ),
                ),
              )
            ],
            child: const HomeCompaniesPage(),
          ),
        );
      },
    ),
  ],
);
