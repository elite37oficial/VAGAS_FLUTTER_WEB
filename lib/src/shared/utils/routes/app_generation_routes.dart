import 'package:flutter/material.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/pages/home_admin_panel_page.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/pages/login_page.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/presenter/pages/register_page.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/presenter/pages/dashboard_recruiter_page.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/redirect_page_route.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

abstract class AppGenerationRoutes {
  Route onGenerateRoute(RouteSettings routeSettings);
  PageRoute toInit();
  PageRoute toSplash();
  PageRoute toHome();
  PageRoute toAdminHome();
  PageRoute toLogin(RouteSettings routeSettings);
  PageRoute toRegister();
}

class AppGenerationRoutesImplementation implements AppGenerationRoutes {
  @override
  PageRoute onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteKeys.init:
        return toInit();
      case RouteKeys.splash:
        return toSplash();
      case RouteKeys.login:
        return toLogin(routeSettings);
      case RouteKeys.register:
        return toRegister();
      case RouteKeys.home:
        return toHome();
      case RouteKeys.homeAdmin:
        return toAdminHome();
      default:
        return toInit();
    }
  }

  @override
  PageRoute toInit() {
    return MaterialPageRoute(
      builder: (_) => const RedirectPageRoute(
        duration: Duration(milliseconds: 0),
        redirectRoute: RouteKeys.splash,
      ),
    );
  }

  @override
  PageRoute toSplash() {
    return MaterialPageRoute(
      builder: (_) => const RedirectPageRoute(
        duration: Duration(milliseconds: 0),
        redirectRoute: RouteKeys.login,
      ),
    );
  }

  @override
  PageRoute toLogin(RouteSettings routeSettings) {
    List<String> loginArgs = routeSettings.arguments != null
        ? routeSettings.arguments as List<String>
        : <String>[];
    return PageRouteBuilder(
      settings: const RouteSettings(name: RouteKeys.login),
      pageBuilder: (_, __, ___) => LoginPage(args: loginArgs),
    );
  }

  @override
  PageRoute toRegister() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: RouteKeys.register),
      pageBuilder: (_, __, ___) => const RegisterPage(),
    );
  }

  @override
  PageRoute toHome() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: RouteKeys.home),
      pageBuilder: (_, __, ___) => const HomeRecruiterPage(),
    );
  }

  @override
  PageRoute toAdminHome() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: RouteKeys.homeAdmin),
      pageBuilder: (_, __, ___) => const HomeAdminPanelPage(),
    );
  }
}
