import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/presenter/bloc/bloc/admin_get_companies_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/presenter/blocs/blocs/admin_get_job_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/blocs/blocs/get_users_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/presenter/blocs/blocs/forgot_password_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/blocs/get_my_self_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/blocs/login_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/presenter/blocs/blocs/register_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/presenter/blocs/blocs/reset_password_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/presenter/bloc/bloc/get_companies_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/presenter/blocs/blocs/create_company_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/blocs/blocs/create_job_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/blocs/blocs/get_all_companies_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/presenter/blocs/blocs/edit_get_all_companies_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/presenter/blocs/blocs/edit_job_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/presenter/blocs/blocs/get_job_by_id_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/presenter/blocs/blocs/get_job_bloc.dart';
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
        BlocProvider<ForgotPasswordBloc>(
            create: (_) => sl<ForgotPasswordBloc>()),
        BlocProvider<ResetPasswordBloc>(create: (_) => sl<ResetPasswordBloc>()),
        BlocProvider<RegisterBloc>(create: (_) => sl<RegisterBloc>()),
        BlocProvider<LoginBloc>(create: (_) => sl<LoginBloc>()),
        BlocProvider<GetMySelfBloc>(create: (_) => sl<GetMySelfBloc>()),
        BlocProvider<AdminGetUsersBloc>(create: (_) => sl<AdminGetUsersBloc>()),
        BlocProvider<AdminGetJobBloc>(create: (_) => sl<AdminGetJobBloc>()),
        BlocProvider<AdminGetCompaniesBloc>(
            create: (_) => sl<AdminGetCompaniesBloc>()),
        BlocProvider<GetCompaniesBloc>(create: (_) => sl<GetCompaniesBloc>()),
        BlocProvider<CreateCompanyBloc>(create: (_) => sl<CreateCompanyBloc>()),
        BlocProvider<GetJobBloc>(create: (_) => sl<GetJobBloc>()),
        BlocProvider<GetAllCompaniesBloc>(
            create: (_) => sl<GetAllCompaniesBloc>()),
        BlocProvider<CreateJobBloc>(create: (_) => sl<CreateJobBloc>()),
        BlocProvider<EditJobBloc>(create: (_) => sl<EditJobBloc>()),
        BlocProvider<EditGetAllCompaniesBloc>(
            create: (_) => sl<EditGetAllCompaniesBloc>()),
        BlocProvider<GetJobByIdBloc>(create: (_) => sl<GetJobByIdBloc>()),
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
