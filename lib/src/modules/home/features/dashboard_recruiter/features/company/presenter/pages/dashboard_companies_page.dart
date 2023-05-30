import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/presenter/bloc/bloc/get_companies_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/presenter/components/company_header_filter_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/presenter/components/company_page_buttons_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/presenter/components/company_top_buttons_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/presenter/components/list_companies_component.dart';
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
  int actualPage = 1;
  int totalPages = 1;
  String username = "";
  List<CompanyEntity> listCompanies = [];
  late GetCompaniesBloc getCompaniesBloc;

  _setCompaniesInfo(GetCompaniesSuccessState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        listCompanies = state.listCompanies.listCompanies;
        actualPage = int.parse(state.listCompanies.actualPage);
        totalPages = int.parse(state.listCompanies.totalPages);
      });
    });
    log(listCompanies.length.toString());
  }

  changePage(newPage) {
    getCompaniesBloc.add(GetCompaniesListEvent(page: newPage));

    setState(() => actualPage = newPage);
  }

  _setUsername() async {
    getCompaniesBloc = BlocProvider.of<GetCompaniesBloc>(context);
    context
        .read<GetCompaniesBloc>()
        .add(GetCompaniesListEvent(page: actualPage));
    username = await SecureStorageManager.readData(StorageKeys.name) ?? "";

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
                  widthPopup: Sizer.calculateHorizontal(context, 70) >= 250
                      ? Sizer.calculateHorizontal(context, 70)
                      : 250,
                  username: username,
                  enterprisesFunction: () => context.push(RouteKeys.companies),
                  jobsFunction: () => context.push(RouteKeys.home),
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
                      const CompanyTopButtonsComponent(),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 50),
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
                                  child: BlocBuilder<GetCompaniesBloc,
                                          GetCompaniesStates>(
                                      bloc: getCompaniesBloc,
                                      builder: (context, state) {
                                        log(state.toString());

                                        if (state is GetCompaniesLoadingState) {
                                          return const Center(
                                              child: CircularProgressIndicator(
                                                  color: AppColors.greyBlue));
                                        }
                                        if (state is GetCompaniesErrorState) {
                                          log(state.message);
                                        }
                                        if (state is GetCompaniesSuccessState) {
                                          _setCompaniesInfo(state);
                                        }

                                        return ListCompaniesComponent(
                                            listCompanies: listCompanies);
                                      }),
                                ),
                                CompanyPageButtonsComponent(
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
                ),
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
                  widthPopup: Sizer.calculateHorizontal(context, 60) >= 220
                      ? Sizer.calculateHorizontal(context, 60)
                      : 220,
                  username: username,
                  enterprisesFunction: () => context.push(RouteKeys.companies),
                  jobsFunction: () => context.push(RouteKeys.home),
                  logout: LogoutHelper.logout,
                  height: Sizer.calculateVertical(context, 70) <= 35
                      ? 35
                      : Sizer.calculateVertical(context, 70),
                ),
                SizedBox(
                  width: size.width * 0.7,
                  child: Column(
                    children: [
                      const CompanyTopButtonsComponent(),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 50),
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
                                  child: BlocBuilder<GetCompaniesBloc,
                                      GetCompaniesStates>(
                                    bloc: getCompaniesBloc,
                                    builder: (context, state) {
                                      if (state is GetCompaniesLoadingState) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                                color: AppColors.greyBlue));
                                      }
                                      if (state is GetCompaniesErrorState) {
                                        log(state.message);
                                      }
                                      if (state is GetCompaniesSuccessState) {
                                        _setCompaniesInfo(state);
                                      }

                                      return ListCompaniesComponent(
                                          listCompanies: listCompanies);
                                    },
                                  ),
                                ),
                                CompanyPageButtonsComponent(
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
        ),
      ),
    );
  }
}
