import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/usecases/get_users_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/datasources/get_users_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/repositories/get_users_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/blocs/blocs/get_users_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/pages/home_admin_panel_page.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/domain/usecases/admin_login_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/infra/datasources/admin_login_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/infra/repositories/admin_login_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/presenter/blocs/blocs/admin_login_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/presenter/pages/admin_login_page.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/usecases/login_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/datasources/login_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/repositories/login_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/blocs/login_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/pages/login_page.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/usecases/register_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/datasources/register_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/repositories/register_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/presenter/blocs/blocs/register_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/presenter/pages/register_page.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/usecases/get_dashboard_recruiter_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/usecases/get_dashboard_recruiter_usecase_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/datasources/dashboard_recruiter_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/datasources/dashboard_recruiter_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/repositories/dashboard_recruiter_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/presenter/blocs/blocs/dashboard_recruiter_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/presenter/pages/dashboard_recruiter_page.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_admin/presenter/pages/home_page.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/services/auth_service.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

final authService = AuthService();

final appRoutesConfig = GoRouter(
  initialLocation: "${RouteKeys.auth}${RouteKeys.login}",
  refreshListenable: authService,
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
            return NoTransitionPage(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<LoginBloc>(
                    create: (context) => LoginBloc(
                        usecase: LoginUsecase(
                      repository: LoginRepositoryImplementation(
                          datasource: LoginDatasourceImplementation(
                        requester: AppRequesterImplementation(),
                      )),
                    )),
                  ),
                ],
                child: const LoginPage(),
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
        GoRoute(
          path: RouteKeys.admin.replaceAll("/", ""),
          name: RouteKeys.admin.replaceAll("/", ""),
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<AdminLoginBloc>(
                    create: (context) => AdminLoginBloc(
                        usecase: AdminLoginUsecase(
                      repository: AdminLoginRepositoryImplementation(
                          datasource: AdminLoginDatasourceImplementation(
                        requester: AppRequesterImplementation(),
                      )),
                    )),
                  ),
                ],
                child: const AdminLoginPage(),
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
              // BlocProvider<DashboardRecruiterBloc>(
              //   create: (context) => DashboardRecruiterBloc(
              //     usecase: DashboardRecruiterUsecaseImp(
              //       repository: DashboardRecruiterRepositoryImplementation(
              //         datasource: GetDashboardDataSourceImp(
              //             // requester: AppRequesterImplementation(),
              //             ),
              //       ),
              //     ),
              //   ),
              // )
            ],
            // child: const DashboardRecruiterPage(),
            child: const HomePage(),
          ),
        );
      },
    ),
  ],
);
