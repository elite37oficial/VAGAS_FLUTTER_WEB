import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/presenter/blocs/blocs/admin_get_job_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/presenter/blocs/events/admin_get_job_event.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/presenter/blocs/states/admin_get_job_states.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/presenter/components/admin_header_filter_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/presenter/components/admin_list_jobs_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/presenter/components/admin_page_buttons_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/presenter/components/admin_top_buttons_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/pages/create_job_page.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/logout_helper.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

class HomeAdminJobsPage extends StatefulWidget {
  const HomeAdminJobsPage({Key? key}) : super(key: key);

  @override
  State<HomeAdminJobsPage> createState() => _HomeAdminJobsPageState();
}

class _HomeAdminJobsPageState extends State<HomeAdminJobsPage> {
  int actualPage = 1;
  int totalPages = 1;
  String username = "";
  String token = "";
  bool isLoaded = false;
  List<JobEntity> listJobs = [];
  late AdminGetJobBloc adminGetJobBloc;

  _setJobsInfo(AdminGetJobSuccessState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        listJobs = state.listJobs.listJobs;
        actualPage = int.parse(state.listJobs.actualPage);
        totalPages = int.parse(state.listJobs.totalPages);
      });
    });
    log(listJobs.length.toString());
  }

  changePage(newPage) {
    adminGetJobBloc.add(AdminGetJobListEvent(page: newPage));

    setState(() => actualPage = newPage);
  }

  _showCreateJobPopup() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          scrollable: true,
          content: Container(
            height: Sizer.calculateVertical(context, 800) >= 720
                ? Sizer.calculateVertical(context, 800)
                : 720,
            width: Sizer.calculateHorizontal(context, 120) >= 300
                ? Sizer.calculateHorizontal(context, 120)
                : 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
            ),
            child: const CreatejobPage(),
          ),
        );
      },
    );
  }

  _setUsername() async {
    adminGetJobBloc = BlocProvider.of<AdminGetJobBloc>(context);
    context.read<AdminGetJobBloc>().add(AdminGetJobListEvent(page: actualPage));
    username = await SecureStorageManager.readData(StorageKeys.name) ?? "";
    token = await SecureStorageManager.readData(StorageKeys.accessToken) ?? "";

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    adminGetJobBloc = BlocProvider.of<AdminGetJobBloc>(context);
    adminGetJobBloc.add(AdminGetJobListEvent(page: totalPages));
    _setUsername();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ResponsiveLayout(
      mobile: Scaffold(
        body: BlocProvider<AdminGetJobBloc>(
          create: (context) => adminGetJobBloc,
          child: Builder(
            builder: (context) {
              return SizedBox(
                height: size.height,
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AdminTopBarWebWidget(
                        widthPopup:
                            Sizer.calculateHorizontal(context, 70) >= 250
                                ? Sizer.calculateHorizontal(context, 70)
                                : 250,
                        username: username,
                        usersFunction: () => context.push(RouteKeys.usersAdmin),
                        enterprisesFunction: () =>
                            context.push(RouteKeys.companiesAdmin),
                        jobsFunction: () => context.push(RouteKeys.jobsAdmin),
                        logout: LogoutHelper.logout,
                        isMobile: true,
                        height: Sizer.calculateVertical(context, 70) <= 35
                            ? 35
                            : Sizer.calculateVertical(context, 70),
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 40, top: 60),
                                child: ResponsiveTextWidget(
                                  text: "Vagas publicadas",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.w700),
                                  hintSemantics: "vagas",
                                  tooltipSemantics: "vagas",
                                  maxLines: 1,
                                  maxFontSize: 32,
                                  minFontSize: 27,
                                ),
                              ),
                            ),
                            AdminTopButtonsComponent(
                                showCreatejobPopup: () =>
                                    _showCreateJobPopup()),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 80, bottom: 50),
                              child: SizedBox(
                                height: Sizer.calculateVertical(context, 450),
                                width: size.width * 0.7,
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 5,
                                  child: Column(
                                    children: [
                                      AdminHeaderFilterComponent(size: size),
                                      Expanded(
                                        child: BlocBuilder<AdminGetJobBloc,
                                            AdminGetJobStates>(
                                          bloc: adminGetJobBloc,
                                          builder: (context, state) {
                                            if (state
                                                is AdminGetJobLoadingState) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: AppColors
                                                              .greyBlue));
                                            }
                                            if (state
                                                is AdminGetJobErrorState) {
                                              log(state.message);
                                            }
                                            if (state
                                                is AdminGetJobSuccessState) {
                                              _setJobsInfo(state);
                                              adminGetJobBloc.add(
                                                  CleanAdminGetJobStateEvent(
                                                      state:
                                                          AdminGetJobInitialState()));
                                            }
                                            return AdminListJobsComponent(
                                                token: token,
                                                listJobs: listJobs);
                                          },
                                        ),
                                      ),
                                      AdminPageButtonsComponent(
                                        actualPage: actualPage,
                                        totalPages: totalPages,
                                        changePage: changePage,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      desktop: Scaffold(
        body: Builder(
          builder: (context) {
            return SizedBox(
              height: size.height,
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AdminTopBarWebWidget(
                      widthPopup: Sizer.calculateHorizontal(context, 60) >= 220
                          ? Sizer.calculateHorizontal(context, 60)
                          : 220,
                      username: username,
                      usersFunction: () => context.push(RouteKeys.usersAdmin),
                      enterprisesFunction: () =>
                          context.push(RouteKeys.companiesAdmin),
                      jobsFunction: () => context.push(RouteKeys.jobsAdmin),
                      logout: LogoutHelper.logout,
                      height: Sizer.calculateVertical(context, 70) <= 35
                          ? 35
                          : Sizer.calculateVertical(context, 70),
                    ),
                    SizedBox(
                      width: size.width * 0.7,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 40, top: 60),
                              child: ResponsiveTextWidget(
                                text: "Vagas publicadas",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.w700),
                                hintSemantics: "vagas",
                                tooltipSemantics: "vagas",
                                maxLines: 1,
                                maxFontSize: 32,
                                minFontSize: 27,
                              ),
                            ),
                          ),
                          AdminTopButtonsComponent(
                              showCreatejobPopup: () => _showCreateJobPopup()),
                          Padding(
                            padding: const EdgeInsets.only(top: 80, bottom: 50),
                            child: SizedBox(
                              height: Sizer.calculateVertical(context, 450),
                              width: size.width * 0.7,
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 5,
                                child: Column(
                                  children: [
                                    AdminHeaderFilterComponent(size: size),
                                    Expanded(
                                      child: BlocBuilder<AdminGetJobBloc,
                                          AdminGetJobStates>(
                                        bloc: adminGetJobBloc,
                                        builder: (context, state) {
                                          log(state.toString());

                                          if (state
                                              is AdminGetJobLoadingState) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: AppColors
                                                            .greyBlue));
                                          }
                                          if (state is AdminGetJobErrorState) {
                                            log(state.message);
                                          }
                                          if (state
                                              is AdminGetJobSuccessState) {
                                            _setJobsInfo(state);
                                            context.read<AdminGetJobBloc>().add(
                                                CleanAdminGetJobStateEvent(
                                                    state:
                                                        AdminGetJobInitialState()));
                                          }
                                          return AdminListJobsComponent(
                                              token: token, listJobs: listJobs);
                                        },
                                      ),
                                    ),
                                    AdminPageButtonsComponent(
                                      actualPage: actualPage,
                                      totalPages: totalPages,
                                      changePage: changePage,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
