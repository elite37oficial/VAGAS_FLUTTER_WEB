import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/presenter/bloc/bloc/admin_get_companies_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/presenter/bloc/events/admin_get_companies_event.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/presenter/bloc/states/admin_get_companies_states.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/presenter/components/admin_company_header_filter_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/presenter/components/admin_company_page_buttons_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/presenter/components/admin_company_top_buttons_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/presenter/components/admin_list_companies_component.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/logout_helper.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

class HomeAdminCompaniesPage extends StatefulWidget {
  const HomeAdminCompaniesPage({Key? key}) : super(key: key);

  @override
  State<HomeAdminCompaniesPage> createState() => HomeAdminCompaniesPageState();
}

class HomeAdminCompaniesPageState extends State<HomeAdminCompaniesPage> {
  int actualPage = 1;
  int totalPages = 1;
  String username = "";
  List<CompanyEntity> listCompanies = [];
  late AdminGetCompaniesBloc adminGetCompaniesBloc;

  _setCompaniesInfo(AdminGetCompaniesSuccessState state) {
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
    adminGetCompaniesBloc.add(AdminGetCompaniesListEvent(page: newPage));

    setState(() => actualPage = newPage);
  }

  _setUsername() async {
    adminGetCompaniesBloc = BlocProvider.of<AdminGetCompaniesBloc>(context);
    username = await SecureStorageManager.readData(StorageKeys.name) ?? "";

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    adminGetCompaniesBloc = BlocProvider.of<AdminGetCompaniesBloc>(context);
    adminGetCompaniesBloc.add(AdminGetCompaniesListEvent(page: totalPages));
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
                AdminTopBarWebWidget(
                  widthPopup: Sizer.calculateHorizontal(context, 70) >= 250
                      ? Sizer.calculateHorizontal(context, 70)
                      : 250,
                  username: username,
                  usersFunction: () => context.push(RouteKeys.usersAdmin),
                  jobsFunction: () => context.push(RouteKeys.jobsAdmin),
                  enterprisesFunction: () =>
                      context.push(RouteKeys.companiesAdmin),
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
                      const AdminCompanyTopButtonsComponent(),
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
                                AdminCompanyHeaderFilterComponent(size: size),
                                Expanded(
                                  child: BlocBuilder<AdminGetCompaniesBloc,
                                          AdminGetCompaniesStates>(
                                      bloc: adminGetCompaniesBloc,
                                      builder: (context, state) {
                                        log(state.toString());

                                        if (state
                                            is AdminGetCompaniesLoadingState) {
                                          return const Center(
                                              child: CircularProgressIndicator(
                                                  color: AppColors.greyBlue));
                                        }
                                        if (state
                                            is AdminGetCompaniesErrorState) {
                                          log(state.message);
                                        }
                                        if (state
                                            is AdminGetCompaniesSuccessState) {
                                          _setCompaniesInfo(state);
                                        }

                                        return AdminListCompaniesComponent(
                                            listCompanies: listCompanies);
                                      }),
                                ),
                                AdminCompanyPageButtonsComponent(
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
                AdminTopBarWebWidget(
                  widthPopup: Sizer.calculateHorizontal(context, 60) >= 220
                      ? Sizer.calculateHorizontal(context, 60)
                      : 220,
                  username: username,
                  usersFunction: () => context.push(RouteKeys.usersAdmin),
                  jobsFunction: () => context.push(RouteKeys.jobsAdmin),
                  enterprisesFunction: () =>
                      context.push(RouteKeys.companiesAdmin),
                  logout: LogoutHelper.logout,
                  height: Sizer.calculateVertical(context, 70) <= 35
                      ? 35
                      : Sizer.calculateVertical(context, 70),
                ),
                SizedBox(
                  width: size.width * 0.7,
                  child: Column(
                    children: [
                      const AdminCompanyTopButtonsComponent(),
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
                                AdminCompanyHeaderFilterComponent(size: size),
                                Expanded(
                                  child: BlocBuilder<AdminGetCompaniesBloc,
                                      AdminGetCompaniesStates>(
                                    bloc: adminGetCompaniesBloc,
                                    builder: (context, state) {
                                      if (state
                                          is AdminGetCompaniesLoadingState) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                                color: AppColors.greyBlue));
                                      }
                                      if (state
                                          is AdminGetCompaniesErrorState) {
                                        log(state.message);
                                      }
                                      if (state
                                          is AdminGetCompaniesSuccessState) {
                                        _setCompaniesInfo(state);
                                      }

                                      return AdminListCompaniesComponent(
                                          listCompanies: listCompanies);
                                    },
                                  ),
                                ),
                                AdminCompanyPageButtonsComponent(
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
