import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/presenter/bloc/bloc/get_company_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/presenter/bloc/events/get_company_event.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/presenter/bloc/states/get_company_states.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/presenter/components/company_header_filter_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/presenter/components/company_page_buttons_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/presenter/components/company_top_buttons_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/company/presenter/components/list_companies_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/presenter/blocs/blocs/create_company_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/presenter/blocs/states/create_company_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/logout_helper.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

class HomeCompaniesPage extends StatefulWidget {
  const HomeCompaniesPage({Key? key}) : super(key: key);

  @override
  State<HomeCompaniesPage> createState() => _HomeCompaniesPageState();
}

class _HomeCompaniesPageState extends State<HomeCompaniesPage> {
  String username = "";

  _setUsername() async {
    username = await SecureStorageManager.readData(StorageKeys.name) ?? "";
    setState(() {});
  }

  List<CompanyEntity> listCompanies = [];

  @override
  void initState() {
    context.read<GetCompanyBloc>().add(GetCompanyListEvent());
    _setUsername();
    super.initState();
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
                  widthPopup: Sizer.calculateHorizontal(context, 40) >= 180
                      ? Sizer.calculateHorizontal(context, 40)
                      : 180,
                  enterprisesFunction: () => context.push(RouteKeys.companies),
                  jobsFunction: () => context.push(RouteKeys.home),
                  logout: LogoutHelper.logout,
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
                                  child: BlocBuilder<GetCompanyBloc,
                                          GetCompanyStates>(
                                      builder: (context, state) {
                                    if (state is GetCompanyLoadingState) {
                                      return const Center(
                                          child: CircularProgressIndicator(
                                              color: AppColors.greyBlue));
                                    }
                                    if (state is GetCompanyErrorState) {
                                      log(state.message);
                                    }
                                    if (state is GetCompanySuccessState) {
                                      listCompanies = state.listCompanies;
                                      log(listCompanies.length.toString());
                                    }

                                    return ListCompaniesComponent(
                                        listCompanies: listCompanies);
                                  }),
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
                  widthPopup: Sizer.calculateHorizontal(context, 40) >= 180
                      ? Sizer.calculateHorizontal(context, 40)
                      : 180,
                  enterprisesFunction: () => context.push(RouteKeys.companies),
                  jobsFunction: () => context.push(RouteKeys.home),
                  logout: LogoutHelper.logout,
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
                                  child: BlocBuilder<GetCompanyBloc,
                                      GetCompanyStates>(
                                    builder: (context, state) {
                                      if (state is GetCompanyLoadingState) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                                color: AppColors.greyBlue));
                                      }
                                      if (state is GetCompanyErrorState) {
                                        log(state.message);
                                      }
                                      if (state is GetCompanySuccessState) {
                                        listCompanies = state.listCompanies;
                                        log(listCompanies.length.toString());
                                      }

                                      return ListCompaniesComponent(
                                          listCompanies: listCompanies);
                                    },
                                  ),
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
  }
}