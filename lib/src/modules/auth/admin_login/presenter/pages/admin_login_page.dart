import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/blocs/blocs/admin_login_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/blocs/events/admin_login_event.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/blocs/states/admin_login_state.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

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
            backgroundColor: Colors.white,
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  Semantics(
                    value: "Acesso ao Admin",
                    tooltip: "Acesso ao Admin",
                    tagForChildren: SemanticsTag("Acesso ao Admin"),
                    hint: "Acesso ao Admin",
                    label: "Acesso ao Admin",
                    child: Text(
                      "Acesso ao Admin",
                      semanticsLabel: 'Acesso ao Admin',
                    ),
                  ),
                  ResponsiveTextWidget(
                    text: "Acesso ao Admin",
                    hintSemantics: "Acesso ao Admin",
                    tooltipSemantics: "Acesso ao Admin",
                  ),
                  AppFieldWidget(
                    fieldSemantic: "Campo de texto do email.",
                    hintSemantic: "email",
                    controller: _emailController,
                    hint: "Email",
                    width: Sizer.calculateHorizontal(context, 150),
                    prefixIcon: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: SvgPicture.asset(
                        AppImages.emailIcon,
                        height: Sizer.calculateVertical(context, 50),
                        width: Sizer.calculateHorizontal(context, 50),
                        package: "vagas_design_system",
                      ),
                    ),
                  ),
                  AppFieldWidget(
                    fieldSemantic: "Campo de texto do senha.",
                    hintSemantic: "password",
                    controller: _passwordController,
                    hint: "Senha",
                    width: Sizer.calculateHorizontal(context, 150),
                    isPassword: true,
                    prefixIcon: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: SvgPicture.asset(
                        AppImages.lockIcon,
                        height: Sizer.calculateVertical(context, 50),
                        width: Sizer.calculateHorizontal(context, 50),
                        package: "vagas_design_system",
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<AdminLoginBloc>().add(LoginEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                            )),
                    child: const ResponsiveTextWidget(
                      text: "Login",
                      hintSemantics: "Login",
                      tooltipSemantics: "Login",
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
