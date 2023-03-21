import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/blocs/blocs/get_users_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/blocs/events/get_users_event.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/blocs/states/get_users_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';

class HomeAdminPanelPage extends StatefulWidget {
  const HomeAdminPanelPage({Key? key}) : super(key: key);

  @override
  State<HomeAdminPanelPage> createState() => _HomeAdminPanelPageState();
}

class _HomeAdminPanelPageState extends State<HomeAdminPanelPage> {
  @override
  void initState() {
    context.read<GetUsersBloc>().add(GetEvent());
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
        List<UserEntity> listUsers = state.listUsers;
        log(listUsers.length.toString());
      }

      return ResponsiveLayout(
        mobile: Scaffold(
          body: SizedBox(
            height: size.height,
            width: size.width,
          ),
        ),
        desktop: Scaffold(
          body: SizedBox(
            height: size.height,
            width: size.width,
          ),
        ),
      );
    });
  }
}
