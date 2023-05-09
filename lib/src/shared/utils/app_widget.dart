import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/blocs/blocs/get_users_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/presenter/blocs/blocs/forgot_password_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/blocs/get_my_self_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/blocs/login_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/presenter/blocs/blocs/register_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/presenter/blocs/blocs/reset_password_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/domain/usecases/get_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/infra/datasources/get_company_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/infra/repositories/get_company_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/presenter/bloc/bloc/get_company_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/domain/usecases/create_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/infra/datasources/create_company_datarouce_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/infra/repositories/create_company_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/presenter/blocs/blocs/create_company_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/blocs/blocs/create_job_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/blocs/blocs/get_companies_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/presenter/blocs/blocs/get_job_bloc.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator.dart';

import 'package:vagas_flutter_web/src/shared/themes/app_themes.dart';
import 'package:vagas_flutter_web/src/shared/utils/behaviors/custom_behavior.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/app_routes_implementation.dart';

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
        BlocProvider<ForgotPasswordBloc>(
            create: (_) => sl<ForgotPasswordBloc>()),
        BlocProvider<ResetPasswordBloc>(create: (_) => sl<ResetPasswordBloc>()),
        BlocProvider<GetJobBloc>(create: (_) => sl<GetJobBloc>()),
        BlocProvider<GetUsersBloc>(create: (_) => sl<GetUsersBloc>()),
        BlocProvider<RegisterBloc>(create: (_) => sl<RegisterBloc>()),
        BlocProvider<LoginBloc>(create: (_) => sl<LoginBloc>()),
        BlocProvider<GetMySelfBloc>(create: (_) => sl<GetMySelfBloc>()),
        BlocProvider<GetCompaniesBloc>(create: (_) => sl<GetCompaniesBloc>()),
        BlocProvider<CreateJobBloc>(create: (_) => sl<CreateJobBloc>()),
      ],
      child: MaterialApp.router(
        // showSemanticsDebugger: debugMode,
        routeInformationParser: appRoutesConfig.routeInformationParser,
        routeInformationProvider: appRoutesConfig.routeInformationProvider,
        routerDelegate: appRoutesConfig.routerDelegate,
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
