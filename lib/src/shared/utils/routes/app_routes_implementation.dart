import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/pages/home_admin_panel_page.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/presenter/pages/forgot_password_page.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/pages/login_page.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/presenter/pages/register_page.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/presenter/pages/reset_password_page.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/presenter/pages/dashboard_companies_page.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/presenter/pages/dashboard_recruiter_page.dart';
import 'package:vagas_flutter_web/src/shared/services/auth_service.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/redirect_page_route.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

final authService = AuthService();

const String home = RouteKeys.init;

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

    // if (!isAuthenticated && isLoginRoute) {
    //   return isAuthRoute ? null : "${RouteKeys.auth}${RouteKeys.login}";
    // }
    // if (!isAuthenticated && isRegisterRoute) {
    //   return isAuthRoute ? null : "${RouteKeys.auth}${RouteKeys.register}";
    // }

    return null;
  },
  routes: [
    GoRoute(
        path: RouteKeys.init,
        name: RouteKeys.init,
        redirect: (context, state) => "${RouteKeys.auth}${RouteKeys.login}",
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: RedirectPageRoute(
              duration: Duration(milliseconds: 0),
              redirectRoute: "${RouteKeys.auth}${RouteKeys.login}",
            ),
          );
        }),
    GoRoute(
        path: RouteKeys.initial,
        name: RouteKeys.initial.replaceAll("/", ""),
        redirect: (context, state) => "${RouteKeys.auth}${RouteKeys.login}",
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: RedirectPageRoute(
              duration: Duration(milliseconds: 0),
              redirectRoute: "${RouteKeys.auth}${RouteKeys.login}",
            ),
          );
        }),
    GoRoute(
      path: RouteKeys.auth,
      name: RouteKeys.auth.replaceAll("/", ""),
      redirect: (_, state) =>
          authService.isAuthenticated ? RouteKeys.home : null,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: RedirectPageRoute(
          duration: Duration(milliseconds: 0),
          redirectRoute: "${RouteKeys.auth}${RouteKeys.login}",
        ),
      ),
      routes: [
        GoRoute(
          path: RouteKeys.login.replaceAll("/", ""),
          name: RouteKeys.login.replaceAll("/", ""),
          pageBuilder: (context, state) {
            List<String> loginArgs =
                state.extra == null ? <String>[] : state.extra as List<String>;
            return NoTransitionPage(
              child: LoginPage(args: loginArgs),
            );
          },
        ),
        GoRoute(
          path: RouteKeys.register.replaceAll("/", ""),
          name: RouteKeys.register.replaceAll("/", ""),
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: RegisterPage(),
            );
          },
        ),
        GoRoute(
          path: RouteKeys.forgotPassword.replaceAll("/", ""),
          name: RouteKeys.forgotPassword.replaceAll("/", ""),
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: ForgotPasswordPage(),
            );
          },
        ),
        GoRoute(
          path: RouteKeys.resetPassword.replaceAll("/", ""),
          name: RouteKeys.resetPassword.replaceAll("/", ""),
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: ResetPasswordPage(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: RouteKeys.homeAdmin,
      name: RouteKeys.homeAdmin.replaceAll("/", ""),
      redirect: (_, __) => !authService.isAuthenticated
          ? "${RouteKeys.auth}${RouteKeys.login}"
          : null,
      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: HomeAdminPanelPage(),
        );
      },
    ),
    GoRoute(
      path: RouteKeys.home,
      name: RouteKeys.home.replaceAll("/", ""),
      redirect: (_, __) => !authService.isAuthenticated
          ? "${RouteKeys.auth}${RouteKeys.login}"
          : null,
      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: HomeRecruiterPage(),
        );
      },
    ),
    GoRoute(
      path: RouteKeys.companies,
      name: RouteKeys.companies.replaceAll("/", ""),
      redirect: (_, __) => !authService.isAuthenticated
          ? "${RouteKeys.auth}${RouteKeys.login}"
          : null,
      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: HomeCompaniesPage(),
        );
      },
    ),
  ],
);
