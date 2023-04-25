import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/pages/create_job_page.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/presenter/blocs/blocs/get_job_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/presenter/components/header_filter_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/presenter/components/list_jobs_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/presenter/components/page_buttons_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/presenter/components/top_buttons_component.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';

class HomeRecruiterPage extends StatefulWidget {
  const HomeRecruiterPage({Key? key}) : super(key: key);

  @override
  State<HomeRecruiterPage> createState() => _HomeRecruiterPageState();
}

class _HomeRecruiterPageState extends State<HomeRecruiterPage> {
  String username = "";
  bool isLoaded = false;
  List<JobEntity> listJobs = [];
  late GetJobBloc getjobBloc;

  _showCreateJobPopup() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrollable: true,
          content: Container(
            height: Sizer.calculateVertical(context, 800) >= 550
                ? Sizer.calculateVertical(context, 800)
                : 550,
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
    getjobBloc = BlocProvider.of<GetJobBloc>(context);
    context.read<GetJobBloc>().add(GetJobListEvent());
    // username = await SecureStorageManager.readData(StorageKeys.name) ?? "";

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _setUsername();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ResponsiveLayout(
      mobile: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TopBarWebWidget(
                  username: username,
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
                          padding: const EdgeInsets.only(bottom: 40, top: 60),
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
                      TopButtonsComponent(
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
                                HeaderFilterComponent(size: size),
                                Expanded(
                                  child: BlocBuilder<GetJobBloc, GetJobStates>(
                                    bloc: getjobBloc,
                                    builder: (context, state) {
                                      log(state.toString());

                                      if (state is GetJobLoadingState) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                                color: AppColors.greyBlue));
                                      }
                                      if (state is GetJobErrorState) {
                                        log(state.message);
                                      }
                                      if (state is GetJobSuccessState) {
                                        listJobs = state.listJobs;
                                        log(listJobs.length.toString());
                                      }
                                      return ListJobsComponent(
                                          listJobs: listJobs);
                                    },
                                  ),
                                ),
                                const PageButtonsComponent(),
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
        ),
      ),
      desktop: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TopBarWebWidget(
                  username: username,
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
                          padding: const EdgeInsets.only(bottom: 40, top: 60),
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
                      TopButtonsComponent(
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
                                HeaderFilterComponent(size: size),
                                Expanded(
                                  child: BlocBuilder<GetJobBloc, GetJobStates>(
                                    bloc: getjobBloc,
                                    builder: (context, state) {
                                      log(state.toString());

                                      if (state is GetJobLoadingState) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                                color: AppColors.greyBlue));
                                      }
                                      if (state is GetJobErrorState) {
                                        log(state.message);
                                      }
                                      if (state is GetJobSuccessState) {
                                        listJobs = state.listJobs;
                                        log(listJobs.length.toString());
                                      }
                                      return ListJobsComponent(
                                          listJobs: listJobs);
                                    },
                                  ),
                                ),
                                const PageButtonsComponent(),
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
        ),
      ),
    );
  }
}
