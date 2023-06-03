import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/blocs/blocs/get_users_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/blocs/events/get_users_event.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/blocs/states/get_users_states.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/components/header_filter_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/components/list_users_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/components/page_buttons_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/components/top_buttons_component.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/logout_helper.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

class HomeAdminPanelPage extends StatefulWidget {
  const HomeAdminPanelPage({Key? key}) : super(key: key);

  @override
  State<HomeAdminPanelPage> createState() => _HomeAdminPanelPageState();
}

class _HomeAdminPanelPageState extends State<HomeAdminPanelPage> {
  String username = "";
  String token = "";
  List<UserEntity> listUsers = [];
  late GetUsersBloc getUsersBloc;

  _setUsersInfo(GetUsersSuccessState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        listUsers = state.listUsers.listUsers;
      });
    });
    log(listUsers.length.toString());
  }

  _setUsername() async {
    getUsersBloc = BlocProvider.of<GetUsersBloc>(context);
    username = await SecureStorageManager.readData(StorageKeys.name) ?? "";
    token = await SecureStorageManager.readData(StorageKeys.accessToken) ?? "";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUsersBloc = BlocProvider.of<GetUsersBloc>(context);
    getUsersBloc.add(GetEvent());
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
                  widthPopup: Sizer.calculateHorizontal(context, 40) >= 180
                      ? Sizer.calculateHorizontal(context, 40)
                      : 180,
                  enterprisesFunction: () =>
                      context.push(RouteKeys.companiesAdmin),
                  jobsFunction: () => context.push(RouteKeys.homeAdmin),
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
                                  child:
                                      BlocBuilder<GetUsersBloc, GetUsersStates>(
                                    bloc: getUsersBloc,
                                    builder: (context, state) {
                                      if (state is GetUsersLoadingState) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                                color: AppColors.greyBlue));
                                      }
                                      if (state is GetUsersErrorState) {
                                        log(state.message);
                                      }
                                      if (state is GetUsersSuccessState) {
                                        _setUsersInfo(state);
                                        log(listUsers.length.toString());
                                      }
                                      return ListUsersComponent(
                                          listUsers: listUsers);
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
                  widthPopup: Sizer.calculateHorizontal(context, 40) >= 180
                      ? Sizer.calculateHorizontal(context, 40)
                      : 180,
                  enterprisesFunction: () =>
                      context.push(RouteKeys.companiesAdmin),
                  jobsFunction: () => context.push(RouteKeys.homeAdmin),
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
                                  child:
                                      BlocBuilder<GetUsersBloc, GetUsersStates>(
                                    bloc: getUsersBloc,
                                    builder: (context, state) {
                                      if (state is GetUsersLoadingState) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                                color: AppColors.greyBlue));
                                      }
                                      if (state is GetUsersErrorState) {
                                        log(state.message);
                                      }
                                      if (state is GetUsersSuccessState) {
                                        _setUsersInfo(state);
                                      }
                                      return ListUsersComponent(
                                          listUsers: listUsers);
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
