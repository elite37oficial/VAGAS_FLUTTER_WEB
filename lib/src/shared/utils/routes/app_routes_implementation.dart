import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/repositories/register_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/usecases/register_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/infra/datasources/register_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/infra/repositories/register_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/presenter/blocs/blocs/register_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/presenter/pages/register_page.dart';
import 'package:vagas_flutter_web/src/modules/home/presenter/pages/home_page.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/services/auth_service.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

final authService = AuthService();

final appRoutesConfig = GoRouter(
  initialLocation: "${RouteKeys.auth}${RouteKeys.register}",
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
          path: RouteKeys.register,
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
      path: RouteKeys.admin,
      name: RouteKeys.admin.replaceAll("/", ""),
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: Container(
            color: Colors.blue,
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
