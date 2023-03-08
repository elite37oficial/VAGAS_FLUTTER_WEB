import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/blocs/blocs/admin_login_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/blocs/events/admin_login_event.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/blocs/states/admin_login_state.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AdminLoginBloc, AdminLoginState>(
      builder: (context, state) {
        if (state is AdminLoginLoadingState) {
          return const LoadingPage();
        }
        if (state is AdminLoginErrorState) {
          log(state.message);
        }
        if (state is AdminLoginSuccessState) {
          AdminUserEntity user = state.adminUser;
          log(user.userId);
          log(user.email);
          log(user.username);
        }

        return ResponsiveLayout(
          mobile: Scaffold(
            backgroundColor: Colors.amber,
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        context.read<AdminLoginBloc>().add(LoginEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                            )),
                    child: const ResponsiveTextWidget(
                      text: "Login",
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          desktop: Scaffold(
            backgroundColor: Colors.blue,
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                  ),
                  TextFormField(
                    controller: _passwordController,
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<AdminLoginBloc>().add(LoginEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                            )),
                    child: const ResponsiveTextWidget(
                      text: "Login",
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
