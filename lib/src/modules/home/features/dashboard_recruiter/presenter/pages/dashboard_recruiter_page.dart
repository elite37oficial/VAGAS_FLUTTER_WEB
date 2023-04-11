import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/presenter/blocs/blocs/get_job_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/presenter/blocs/events/get_job_event.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/presenter/blocs/states/get_job_states.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/presenter/components/header_filter_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/presenter/components/list_jobs_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/presenter/components/page_buttons_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/presenter/components/top_buttons_component.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class HomeRecruiterPage extends StatefulWidget {
  const HomeRecruiterPage({Key? key}) : super(key: key);

  @override
  State<HomeRecruiterPage> createState() => _HomeRecruiterPageState();
}

class _HomeRecruiterPageState extends State<HomeRecruiterPage> {
  List<JobEntity> listJobs = [
    const JobEntity(
        id: 'id',
        title: 'Software Engineer',
        enterprise: 'Ifood',
        link: 'link',
        imageLogo:
            'https://static.ifood.com.br/webapp/images/logo-smile-512x512.png',
        local: 'São Paulo - Remoto',
        period: 'Tempo Integral - Jr/Pleno  ',
        createdAt: '29/12/2022',
        status: 'Em Aberto'),
    const JobEntity(
        id: 'id',
        title: 'Web Developer',
        enterprise: 'Facebook',
        link: 'link',
        imageLogo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Facebook_logo_36x36.svg/800px-Facebook_logo_36x36.svg.png?20150724010035',
        local: 'Nova Iorque - Remoto',
        period: 'Tempo Integral - Pleno  ',
        createdAt: '08/01/2023',
        status: 'Cancelada'),
    const JobEntity(
        id: 'id',
        title: 'Data Analytics',
        enterprise: 'Linkedin',
        link: 'link',
        imageLogo: 'https://cdn-icons-png.flaticon.com/512/174/174857.png',
        local: 'São Paulo - Hibrido',
        period: 'Tempo Integral - Senior  ',
        createdAt: '12/07/2022',
        status: 'Fechada'),
    const JobEntity(
        id: 'id',
        title: 'Software Engineer',
        enterprise: 'Google',
        link: 'link',
        imageLogo:
            'https://static.vecteezy.com/ti/vetor-gratis/p3/10353285-colorido-google-logo-on-white-background-gratis-vetor.jpg',
        local: 'Vancouver - Hibrido',
        period: 'Tempo Integral - Pleno  ',
        createdAt: '24/11/2022',
        status: 'Fechada'),
  ];
  @override
  void initState() {
    context.read<GetJobBloc>().add(GetJobListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<GetJobBloc, GetJobStates>(builder: (context, state) {
      if (state is GetJobLoadingState) {
        return const LoadingPage();
      }
      if (state is GetJobErrorState) {
        log(state.message);
      }
      if (state is GetJobSuccessState) {
        listJobs = state.listJobs;
        log(listJobs.length.toString());
      }
      return ResponsiveLayout(
        mobile: Scaffold(
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TopBarWebWidget(
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
                        const TopButtonsComponent(),
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
                                    child:
                                        ListJobsComponent(listJobs: listJobs),
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
                        const TopButtonsComponent(),
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
                                    child:
                                        ListJobsComponent(listJobs: listJobs),
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
    });
  }
}
