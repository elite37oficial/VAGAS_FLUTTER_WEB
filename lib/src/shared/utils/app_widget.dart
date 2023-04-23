import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/usecases/get_users_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/datasources/get_users_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/repositories/get_users_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/blocs/blocs/get_users_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/blocs/get_my_self_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/blocs/login_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/presenter/blocs/blocs/register_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/domain/usecases/create_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/domain/usecases/get_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/infra/datasources/create_company_datarouce_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/infra/datasources/get_company_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/infra/repositories/create_company_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/infra/repositories/get_company_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/bloc/bloc/create_company_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/bloc/bloc/get_company_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/presenter/blocs/blocs/get_job_bloc.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator.dart';

import 'package:vagas_flutter_web/src/shared/themes/app_themes.dart';
import 'package:vagas_flutter_web/src/shared/utils/behaviors/custom_behavior.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/app_generation_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetCompanyBloc>(
          create: (_) => GetCompanyBloc(
            usecase: GetCompanyUsecase(
              repository: GetCompanyRepositoryImplementation(
                datasource: GetCompanyDatasourceImplementation(
                  requester: AppRequesterImplementation(),
                ),
              ),
            ),
          ),
        ),
        BlocProvider<CreateCompanyBloc>(
          create: (_) => CreateCompanyBloc(
            usecase: CreateCompanyUsecase(
              repository: CreateCompanyRepositoryImplementation(
                datasource: CreateCompanyDatasourceImplementation(
                  requester: AppRequesterImplementation(),
                ),
              ),
            ),
          ),
        ),
        BlocProvider<GetJobBloc>(create: (_) => sl<GetJobBloc>()),
        BlocProvider<GetUsersBloc>(
          create: (_) => GetUsersBloc(
            usecase: GetUsersUsecase(
              repository: GetUsersRepositoryImplementation(
                datasource: GetUsersDatasourceImplementation(
                  requester: AppRequesterImplementation(),
                ),
              ),
            ),
          ),
        ),
        BlocProvider<RegisterBloc>(create: (_) => sl<RegisterBloc>()),
        BlocProvider<LoginBloc>(create: (_) => sl<LoginBloc>()),
        BlocProvider<GetMySelfBloc>(create: (_) => sl<GetMySelfBloc>()),
      ],
      child: MaterialApp(
        // showSemanticsDebugger: debugMode,
        onGenerateRoute: (routeSettings) =>
            AppGenerationRoutesImplementation().onGenerateRoute(routeSettings),
        debugShowCheckedModeBanner: false,
        scrollBehavior: CustomScrollBehavior(),
        title: 'Vagas Elite37',
        theme: AppThemes.lightTheme(),
        darkTheme: AppThemes.darkTheme(),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
