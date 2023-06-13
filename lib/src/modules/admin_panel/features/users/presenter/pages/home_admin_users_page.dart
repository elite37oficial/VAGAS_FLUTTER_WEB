import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/presenter/components/admin_page_buttons_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/blocs/blocs/get_users_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/blocs/events/get_users_event.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/blocs/states/get_users_states.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/components/header_filter_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/components/list_users_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/components/top_buttons_component.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/logout_helper.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

class HomeAdminUsersPage extends StatefulWidget {
  const HomeAdminUsersPage({Key? key}) : super(key: key);

  @override
  State<HomeAdminUsersPage> createState() => _HomeAdminUsersPageState();
}

class _HomeAdminUsersPageState extends State<HomeAdminUsersPage> {
  int actualPage = 1;
  int totalPages = 1;
  String username = "";
  String token = "";
  List<UserEntity> listUsers = [];
  late AdminGetUsersBloc getUsersBloc;

  _setUsersInfo(AdminGetUsersSuccessState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        listUsers = state.listUsers.listUsers;
        actualPage = int.parse(state.listUsers.actualPage);
        totalPages = int.parse(state.listUsers.totalPages);
      });
    });
    log(listUsers.length.toString());
  }

  changePage(newPage) {
    getUsersBloc.add(AdminDoGetUsersEvent(page: newPage));

    setState(() => actualPage = newPage);
  }

  _setUsername() async {
    getUsersBloc = BlocProvider.of<AdminGetUsersBloc>(context);
    username = await SecureStorageManager.readData(StorageKeys.name) ?? "";
    token = await SecureStorageManager.readData(StorageKeys.accessToken) ?? "";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUsersBloc = BlocProvider.of<AdminGetUsersBloc>(context);
    getUsersBloc.add(AdminDoGetUsersEvent(page: totalPages));
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
                  widthPopup: Sizer.calculateHorizontal(context, 40) >= 180
                      ? Sizer.calculateHorizontal(context, 40)
                      : 180,
                  usersFunction: () => context.push(RouteKeys.usersAdmin),
                  enterprisesFunction: () =>
                      context.push(RouteKeys.companiesAdmin),
                  jobsFunction: () => context.push(RouteKeys.jobsAdmin),
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
                            text: "Usuários",
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.w700),
                            hintSemantics: "usuários",
                            tooltipSemantics: "usuários",
                            maxLines: 1,
                            maxFontSize: 32,
                            minFontSize: 27,
                          ),
                        ),
                      ),
                      const TopButtonsComponent(),
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
                                HeaderFilterComponent(size: size),
                                Expanded(
                                  child: BlocBuilder<AdminGetUsersBloc,
                                      AdminGetUsersStates>(
                                    bloc: getUsersBloc,
                                    builder: (context, state) {
                                      if (state is AdminGetUsersLoadingState) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                                color: AppColors.greyBlue));
                                      }
                                      if (state is AdminGetUsersErrorState) {
                                        log(state.message);
                                      }
                                      if (state is AdminGetUsersSuccessState) {
                                        _setUsersInfo(state);
                                        getUsersBloc.add(
                                            AdminCleanGetUsersStateEvent(
                                                state:
                                                    AdminGetUsersInitialState()));
                                      }
                                      return ListUsersComponent(
                                          listUsers: listUsers);
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
                  widthPopup: Sizer.calculateHorizontal(context, 40) >= 180
                      ? Sizer.calculateHorizontal(context, 40)
                      : 180,
                  usersFunction: () => context.push(RouteKeys.usersAdmin),
                  enterprisesFunction: () =>
                      context.push(RouteKeys.companiesAdmin),
                  jobsFunction: () =>
                      context.pushReplacement(RouteKeys.jobsAdmin),
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
                      const TopButtonsComponent(),
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
                                HeaderFilterComponent(size: size),
                                Expanded(
                                  child: BlocBuilder<AdminGetUsersBloc,
                                      AdminGetUsersStates>(
                                    bloc: getUsersBloc,
                                    builder: (context, state) {
                                      if (state is AdminGetUsersLoadingState) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                                color: AppColors.greyBlue));
                                      }
                                      if (state is AdminGetUsersErrorState) {
                                        log(state.message);
                                      }
                                      if (state is AdminGetUsersSuccessState) {
                                        _setUsersInfo(state);
                                        getUsersBloc.add(
                                            AdminCleanGetUsersStateEvent(
                                                state:
                                                    AdminGetUsersInitialState()));
                                      }
                                      return ListUsersComponent(
                                          listUsers: listUsers);
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
        ),
      ),
    );
  }
}
