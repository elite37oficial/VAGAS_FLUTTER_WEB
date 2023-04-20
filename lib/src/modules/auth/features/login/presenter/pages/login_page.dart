import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/blocs/login_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/events/login_event.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/states/login_state.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/components/login_fields_component.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/components/login_logo_background_component.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/components/login_register_button_component.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool emailError = false;
  bool passwordError = false;

  _validateForm(GlobalKey<FormState> formKey) {
    String email = emailController.text.replaceAll(" ", "");
    setState(() {
      emailError = email.isEmpty || email.length < 6 || !email.contains("@");

      passwordError =
          passwordController.text.isEmpty || passwordController.text.length < 8;
    });

    if (formKey.currentState!.validate()) {
      if (!emailError && !passwordError) {
        context.read<LoginBloc>().add(
              DoLoginEvent(
                email: emailController.text,
                password: passwordController.text,
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double returnHeight() {
      if (size.height >= ResponsiveLayout.desktopHeightBreakpoint) {
        return size.height;
      } else if (size.height >= ResponsiveLayout.mobileHeightBreakpoint) {
        return size.height * 1;
      } else {
        return size.height * 1;
      }
    }

    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is LoginLoadingState) {
        return const LoadingPage();
      }
      if (state is LoginErrorState) {
        log(state.message);
      }
      if (state is LoginSuccessState) {
        if (state.userRole == UserRole.admin) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            context.push(RouteKeys.homeAdmin);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            context.push(RouteKeys.home);
          });
        }
      }

      return ResponsiveLayout(
        mobile: Scaffold(
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Sizer.calculateVertical(context, 70),
                    bottom: Sizer.calculateVertical(context, 120),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Sizer.calculateHorizontal(context, 250),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ResponsiveTextWidget(
                                text: "Entrar",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w900,
                                    ),
                                maxLines: 1,
                                maxFontSize: 50,
                                minFontSize: 32,
                                textScaleFactor: 1.5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      LoginFieldsComponent(
                        formKey: formKey,
                        emailError: emailError,
                        passwordError: passwordError,
                        emailController: emailController,
                        passwordController: passwordController,
                        width: 250,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 35,
                          maxHeight: Sizer.calculateVertical(context, 55) >= 36
                              ? Sizer.calculateVertical(context, 55)
                              : 36,
                        ),
                        child: SizedBox(
                          height: Sizer.calculateVertical(context, 55) >= 36
                              ? Sizer.calculateVertical(context, 55)
                              : 36,
                          width: Sizer.calculateHorizontal(context, 250),
                          child: ElevatedButtonTheme(
                            data: ElevatedButtonThemeData(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: AppColors.greyBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () => _validateForm(formKey),
                              child: ResponsiveTextWidget(
                                text: "Entrar",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                hintSemantics: "Login",
                                tooltipSemantics: "Login",
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const LoginRegisterButtonComponent(
                        width: 250,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        desktop: Scaffold(
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoginLogoBackgroundComponent(size: size),
                SingleChildScrollView(
                  child: SizedBox(
                    height: returnHeight(),
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: Sizer.calculateHorizontal(context, 10),
                        top: Sizer.calculateVertical(context, 80),
                        bottom: Sizer.calculateVertical(context, 120),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Sizer.calculateHorizontal(context, 150),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  ResponsiveTextWidget(
                                    text: "Entrar",
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.w900,
                                        ),
                                    maxLines: 1,
                                    maxFontSize: 50,
                                    minFontSize: 32,
                                    textScaleFactor: 1.5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          LoginFieldsComponent(
                            formKey: formKey,
                            emailError: emailError,
                            passwordError: passwordError,
                            emailController: emailController,
                            passwordController: passwordController,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 35,
                              maxHeight:
                                  Sizer.calculateVertical(context, 55) >= 36
                                      ? Sizer.calculateVertical(context, 55)
                                      : 36,
                            ),
                            child: SizedBox(
                              height: Sizer.calculateVertical(context, 55) >= 36
                                  ? Sizer.calculateVertical(context, 55)
                                  : 36,
                              width: Sizer.calculateHorizontal(context, 150),
                              child: ElevatedButtonTheme(
                                data: ElevatedButtonThemeData(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: AppColors.greyBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: () => _validateForm(formKey),
                                  child: ResponsiveTextWidget(
                                    text: "Entrar",
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                    hintSemantics: "Login",
                                    tooltipSemantics: "Login",
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const LoginRegisterButtonComponent(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
