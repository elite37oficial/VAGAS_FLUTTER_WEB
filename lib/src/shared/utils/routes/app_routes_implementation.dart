import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/usecases/admin_login_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/infra/datasources/admin_login_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/infra/repositories/admin_login_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/blocs/blocs/admin_login_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/pages/admin_login_page.dart';
import 'package:vagas_flutter_web/src/modules/home/presenter/pages/home_page.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/services/auth_service.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

final authService = AuthService();

final appRoutesConfig = GoRouter(
  initialLocation: RouteKeys.admin,
  refreshListenable: authService,
  redirect: (context, state) {
    final isAuthenticated = authService.isAuthenticated;
    final isAuthRoute = state.subloc == RouteKeys.auth;
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
        path: RouteKeys.initial,
        name: RouteKeys.initial.replaceAll("/", ""),
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: Container(),
          );
        }),
    GoRoute(
      path: RouteKeys.auth,
      name: RouteKeys.auth.replaceAll("/", ""),
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: Container(),
        );
      },
      routes: [
        GoRoute(
          path: RouteKeys.login.replaceAll("/", ""),
          name: RouteKeys.login.replaceAll("/", ""),
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: Container(),
            );
          },
        ),
        GoRoute(
          path: RouteKeys.register.replaceAll("/", ""),
          name: RouteKeys.register.replaceAll("/", ""),
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: Container(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: RouteKeys.admin,
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
    GoRoute(
      path: RouteKeys.home,
      name: RouteKeys.home.replaceAll("/", ""),
      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: HomePage(),
        );
      },
    ),
  ],
);
