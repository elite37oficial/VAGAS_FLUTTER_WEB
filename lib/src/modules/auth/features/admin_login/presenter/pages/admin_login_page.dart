import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/domain/entities/admin_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/presenter/blocs/blocs/admin_login_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/presenter/blocs/events/admin_login_event.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/presenter/blocs/states/admin_login_state.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/presenter/components/admin_login_fields_component.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/presenter/components/admin_login_logo_background_component.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
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
        context.read<AdminLoginBloc>().add(
              LoginEvent(
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

    return BlocBuilder<AdminLoginBloc, AdminLoginState>(
      builder: (context, state) {
        if (state is AdminLoginLoadingState) {
          return const LoadingPage();
        }
        if (state is AdminLoginErrorState) {
          log(state.message);
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            context.pushReplacement(RouteKeys.homeAdmin);
          });
        }
        if (state is AdminLoginSuccessState) {
          AdminUserEntity user = state.adminUser;
          log(user.userId);
          log(user.email);
          log(user.username);

          WidgetsBinding.instance.addPostFrameCallback((_) async {
            context.pushReplacement(RouteKeys.homeAdmin);
          });
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
                      bottom: Sizer.calculateVertical(context, 20),
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
                        AdminLoginFieldsComponent(
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
                            maxHeight:
                                Sizer.calculateVertical(context, 55) >= 36
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
                        Align(
                          alignment: Alignment.center,
                          child: SelectionArea(
                            child: GestureDetector(
                              onTap: () => context.pushReplacement(
                                  "${RouteKeys.auth}${RouteKeys.login}"),
                              child: AutoSizeText.rich(
                                maxLines: 1,
                                TextSpan(
                                  text: "Voltar para o ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: AppColors.lightGrey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                  children: [
                                    TextSpan(
                                      text: "Login",
                                      semanticsLabel: "Login",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: AppColors.greyBlue,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                  AdminLoginLogoBackgroundComponent(size: size),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: returnHeight(),
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: Sizer.calculateHorizontal(context, 10),
                          top: Sizer.calculateVertical(context, 80),
                          bottom: Sizer.calculateVertical(context, 30),
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
                            AdminLoginFieldsComponent(
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
                                height:
                                    Sizer.calculateVertical(context, 55) >= 36
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
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SelectionArea(
                                child: GestureDetector(
                                  onTap: () => context.pushReplacement(
                                      "${RouteKeys.auth}${RouteKeys.login}"),
                                  child: AutoSizeText.rich(
                                    maxLines: 1,
                                    TextSpan(
                                      text: "Voltar para o ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: AppColors.lightGrey,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20,
                                          ),
                                      children: [
                                        TextSpan(
                                          text: "Login",
                                          semanticsLabel: "Login",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: AppColors.greyBlue,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
      },
    );
  }
}
