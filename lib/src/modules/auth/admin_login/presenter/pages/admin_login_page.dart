import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/blocs/blocs/admin_login_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/blocs/events/admin_login_event.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/blocs/states/admin_login_state.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/components/admin_login_fields_component.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/components/admin_login_logo_background_component.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/components/admin_login_social_buttons_component.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/components/admin_login_social_buttons_mobile_component.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: size.height * 1.1,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Material(
                            color: AppColors.greyBlue,
                            elevation: 5,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50)),
                            ),
                            child: SizedBox(
                              width: size.width,
                              height: Sizer.calculateVertical(context, 80),
                              child: Center(
                                child: SelectionArea(
                                  child: AutoSizeText.rich(
                                    maxLines: 1,
                                    TextSpan(
                                      text: "Elite ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 37,
                                          ),
                                      children: [
                                        TextSpan(
                                          text: "Vagas",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 37,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Sizer.calculateHorizontal(context, 250),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ResponsiveTextWidget(
                                  text: "Olá anunciante!",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 50,
                                      ),
                                  maxLines: 1,
                                ),
                                ResponsiveTextWidget(
                                  text: "anuncie aqui as suas vagas",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 27,
                                      ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        AdminLoginFieldsComponent(
                          emailController: emailController,
                          passwordController: passwordController,
                          width: 250,
                        ),
                        SizedBox(
                          height: Sizer.calculateVertical(context, 50),
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
                              onPressed: () =>
                                  context.read<AdminLoginBloc>().add(LoginEvent(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      )),
                              child: ResponsiveTextWidget(
                                text: "Login",
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
                        ResponsiveTextWidget(
                          text: "OU",
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.lightGrey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 27,
                                  ),
                          maxLines: 1,
                        ),
                        const AdminLoginSocialButtonsMobileComponent(),
                        Align(
                          alignment: Alignment.center,
                          child: SelectionArea(
                            child: AutoSizeText.rich(
                              maxLines: 1,
                              TextSpan(
                                text: "Ainda não tem conta? ",
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
                                    text: "Cadastre-se",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
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
              ),
            ),
          ),
          desktop: Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: Row(
                children: [
                  AdminLoginLogoBackgroundComponent(size: size),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Sizer.calculateHorizontal(context, 10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: Sizer.calculateHorizontal(context, 150),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ResponsiveTextWidget(
                                  text: "Olá anunciante!",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 50,
                                      ),
                                  maxLines: 1,
                                ),
                                ResponsiveTextWidget(
                                  text: "anuncie aqui as suas vagas",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 27,
                                      ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        AdminLoginFieldsComponent(
                          emailController: emailController,
                          passwordController: passwordController,
                        ),
                        SizedBox(
                          height: Sizer.calculateVertical(context, 50),
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
                              onPressed: () =>
                                  context.read<AdminLoginBloc>().add(LoginEvent(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      )),
                              child: ResponsiveTextWidget(
                                text: "Login",
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
                        ResponsiveTextWidget(
                          text: "OU",
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.lightGrey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 27,
                                  ),
                          maxLines: 1,
                        ),
                        const AdminLoginSocialButtonsComponent(),
                        Align(
                          alignment: Alignment.center,
                          child: SelectionArea(
                            child: AutoSizeText.rich(
                              maxLines: 1,
                              TextSpan(
                                text: "Ainda não tem conta? ",
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
                                    text: "Cadastre-se",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
