import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/bloc/bloc/get_company_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/bloc/events/get_company_event.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/bloc/states/get_company_states.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/components/company_header_filter_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/components/company_top_buttons_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/components/list_companies_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/components/company_page_buttons_component.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class HomeCompaniesPage extends StatefulWidget {
  const HomeCompaniesPage({Key? key}) : super(key: key);

  @override
  State<HomeCompaniesPage> createState() => _HomeCompaniesPageState();
}

class _HomeCompaniesPageState extends State<HomeCompaniesPage> {
  List<CompanyEntity> listCompanies = [
    const CompanyEntity(
        id: 'id',
        name: 'Ifood',
        location: 'São Paulo',
        description:
            'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum',
        status: 'Ativa',
        image64:
            'https://static.ifood.com.br/webapp/images/logo-smile-512x512.png'),
    const CompanyEntity(
        id: 'id',
        name: 'Facebook',
        location: 'São Paulo',
        description:
            'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum',
        status: 'Inativa',
        image64:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Facebook_logo_36x36.svg/800px-Facebook_logo_36x36.svg.png?20150724010035'),
    const CompanyEntity(
        id: 'id',
        name: 'Google',
        location: 'São Paulo',
        description:
            'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum',
        status: 'Fechada',
        image64:
            'https://static.vecteezy.com/ti/vetor-gratis/p3/10353285-colorido-google-logo-on-white-background-gratis-vetor.jpg'),
  ];

  @override
  void initState() {
    context.read<GetCompanyBloc>().add(GetCompanyListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<GetCompanyBloc, GetCompanyStates>(
        builder: (context, state) {
      if (state is GetCompanyLoadingState) {
        return const LoadingPage();
      }
      if (state is GetCompanyErrorState) {
        log(state.message);
      }
      if (state is GetCompanySuccessState) {
        listCompanies = state.listCompanies;
        log(listCompanies.length.toString());
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
                              text: "Empresas cadastradas",
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.w700),
                              hintSemantics: "empresas",
                              tooltipSemantics: "empresas",
                              maxLines: 1,
                              maxFontSize: 32,
                              minFontSize: 27,
                            ),
                          ),
                        ),
                        const CompanyTopButtonsComponent(),
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
                                  CompanyHeaderFilterComponent(size: size),
                                  Expanded(
                                    child: ListCompaniesComponent(
                                        listCompanies: listCompanies),
                                  ),
                                  const CompanyPageButtonsComponent(),
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
                              text: "Empresas cadastradas",
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.w700),
                              hintSemantics: "empresas",
                              tooltipSemantics: "empresas",
                              maxLines: 1,
                              maxFontSize: 32,
                              minFontSize: 27,
                            ),
                          ),
                        ),
                        const CompanyTopButtonsComponent(),
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
                                  CompanyHeaderFilterComponent(size: size),
                                  Expanded(
                                    child: ListCompaniesComponent(
                                        listCompanies: listCompanies),
                                  ),
                                  const CompanyPageButtonsComponent(),
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
