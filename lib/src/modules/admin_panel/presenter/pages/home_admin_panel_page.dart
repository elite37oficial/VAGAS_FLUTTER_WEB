import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/blocs/blocs/get_users_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/blocs/events/get_users_event.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/blocs/states/get_users_states.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/components/header_filter_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/components/list_users_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/components/page_buttons_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/components/top_buttons_component.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';

class HomeAdminPanelPage extends StatefulWidget {
  const HomeAdminPanelPage({Key? key}) : super(key: key);

  @override
  State<HomeAdminPanelPage> createState() => _HomeAdminPanelPageState();
}

class _HomeAdminPanelPageState extends State<HomeAdminPanelPage> {
  String username = "";

  _setUsername() async {
    username = await SecureStorageManager.readData(StorageKeys.name) ?? "";
  }

  List<UserEntity> listUsers = [
    UserEntity(
      userId: "0",
      isAdmin: false,
      username: "username",
      email: "user@email.com",
      createdAt: "27/03/2023",
      listJobs: [],
      about: "Lorem Ipslum",
      profession: "Recrutador",
      status: "Em Aberto",
      listEnterprises: [],
      updatedAt: "27/04/2023",
    ),
    UserEntity(
      userId: "0",
      isAdmin: false,
      username: "username",
      email: "user@email.com",
      createdAt: "27/03/2023",
      listJobs: [],
      about: "Lorem Ipslum",
      profession: "Recrutador",
      status: "Fechada",
      listEnterprises: [],
      updatedAt: "27/04/2023",
    ),
    UserEntity(
      userId: "0",
      isAdmin: false,
      username: "username",
      email: "user@email.com",
      createdAt: "27/03/2023",
      listJobs: [],
      about:
          "Lorem Ipslum Lorem Ipslum Lorem Ipslum Lorem Ipslum Lorem Ipslum Lorem Ipslum Lorem IpslumLorem Ipslum Lorem Ipslum Lorem Ipslum Lorem Ipslum Lorem Ipslum Lorem IpslumLorem IpslumLorem IpslumLorem IpslumLorem IpslumLorem IpslumLorem IpslumLorem IpslumLorem IpslumLorem IpslumLorem IpslumLorem Ipslum ",
      profession: "Recrutador",
      status: "Cancelada",
      listEnterprises: [],
      updatedAt: "27/04/2023",
    ),
  ];
  @override
  void initState() {
    context.read<GetUsersBloc>().add(GetEvent());
    _setUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<GetUsersBloc, GetUsersStates>(builder: (context, state) {
      if (state is GetUsersLoadingState) {
        return const LoadingPage();
      }
      if (state is GetUsersErrorState) {
        log(state.message);
      }
      if (state is GetUsersSuccessState) {
        listUsers = state.listUsers;
        log(listUsers.length.toString());
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
                                    child: ListUsersComponent(
                                        listUsers: listUsers),
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
                                    child: ListUsersComponent(
                                        listUsers: listUsers),
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
