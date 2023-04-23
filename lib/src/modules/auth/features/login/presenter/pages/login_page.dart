import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/blocs/get_my_self_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/blocs/login_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/components/login_fields_component.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/components/login_logo_background_component.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/components/login_register_button_component.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

class LoginPage extends StatefulWidget {
  final List<String> args;
  const LoginPage({Key? key, required this.args}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc loginBloc;
  late GetMySelfBloc getMySelfBloc;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool emailError = false;
  bool passwordError = false;

  bool loaded = false;

  _getBloc(BuildContext context) async {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    getMySelfBloc = BlocProvider.of<GetMySelfBloc>(context);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fillControllers();
  }

  _verifyLoaded(String userId) {
    !loaded
        ? context.read<GetMySelfBloc>().add(DoGetMySelfEvent(userId: userId))
        : null;
    loaded = true;
  }

  _showErrorAlert(String message) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) {
        return ErrorPopUpWidget.show(
          context: context,
          height: Sizer.calculateVertical(context, 350) >= 320
              ? Sizer.calculateVertical(context, 350)
              : 320,
          width: Sizer.calculateHorizontal(context, 170) >= 370
              ? Sizer.calculateHorizontal(context, 170)
              : 370,
          message: message,
        );
      },
    );
  }

  _fillControllers() async {
    if (widget.args.isNotEmpty) {
      emailController.text = widget.args[0];
      passwordController.text = widget.args[1];
      await Future.delayed(const Duration(milliseconds: 300));
      _validateForm(formKey);
    }
  }

  _validateForm(GlobalKey<FormState> formKey) {
    String email = emailController.text.replaceAll(" ", "");
    setState(() {
      emailError = email.isEmpty || email.length < 6 || !email.contains("@");

      passwordError =
          passwordController.text.isEmpty || passwordController.text.length < 8;
    });

    if (formKey.currentState!.validate()) {
      if (!emailError && !passwordError) {
        loginBloc.add(
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
    _getBloc(context);

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

    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
            bloc: loginBloc,
            listener: (context, state) async {
              if (state is LoginErrorState) {
                log(state.message);
                loginBloc.add(CleanStateEvent(state: LoginInitialState()));
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  _showErrorAlert(state.message);
                });
              }
              if (state is LoginSuccessState) {
                await SecureStorageManager.saveData(
                    StorageKeys.accessToken, state.token);

                _verifyLoaded(state.userId);
                loginBloc.add(CleanStateEvent(state: LoginInitialState()));
              }
            }),
        BlocListener<GetMySelfBloc, GetMySelfState>(
          bloc: getMySelfBloc,
          listener: (context, getState) {
            if (getState is GetMySelfStateSuccessState) {
              if (getState.role == UserRole.admin) {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  Navigator.pushNamed(context, RouteKeys.homeAdmin);
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  Navigator.pushNamed(context, RouteKeys.home);
                });
              }
              getMySelfBloc.add(CleanStateGetMySelfEvent(
                  state: GetMySelfStateInitialState()));
            }

            if (getState is GetMySelfStateErrorState) {
              log(getState.message);
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                _showErrorAlert(getState.message);
              });
              getMySelfBloc.add(CleanStateGetMySelfEvent(
                  state: GetMySelfStateInitialState()));
            }
          },
        ),
      ],
      child: loginBloc.state is LoginLoadingState ||
              getMySelfBloc.state is GetMySelfStateLoadingState
          ? const LoadingPage()
          : ResponsiveLayout(
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
                                  width:
                                      Sizer.calculateHorizontal(context, 150),
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
                                    maxHeight: Sizer.calculateVertical(
                                                context, 55) >=
                                            36
                                        ? Sizer.calculateVertical(context, 55)
                                        : 36,
                                  ),
                                  child: SizedBox(
                                    height: Sizer.calculateVertical(
                                                context, 55) >=
                                            36
                                        ? Sizer.calculateVertical(context, 55)
                                        : 36,
                                    width:
                                        Sizer.calculateHorizontal(context, 150),
                                    child: ElevatedButtonTheme(
                                      data: ElevatedButtonThemeData(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor: AppColors.greyBlue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
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
            ),
    );
  }
}
