import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/presenter/blocs/blocs/forgot_password_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/presenter/components/forgot_password_background_component.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/presenter/components/forgot_password_button_component.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late ForgotPasswordBloc forgotPasswordBloc;

  TextEditingController emailController = TextEditingController();
  bool emailError = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  _showSuccessAlert(String message) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) {
        return SuccessPopUpWidget.show(
          context: context,
          height: Sizer.calculateVertical(context, 350),
          width: Sizer.calculateHorizontal(context, 350) <= 600
              ? Sizer.calculateHorizontal(context, 350)
              : 600,
          message: message,
          function: () {
            context.pop();
            context.push("${RouteKeys.auth}${RouteKeys.login}");
          },
        );
      },
    );
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

  _validateForm(GlobalKey<FormState> formKey) {
    String email = emailController.text.replaceAll(" ", "");
    setState(() {
      emailError = email.isEmpty || email.length < 6 || !email.contains("@");
    });

    if (formKey.currentState!.validate()) {
      if (!emailError) {
        emailError = false;

        forgotPasswordBloc.add(
          DoForgotPasswordEvent(email: emailController.text),
        );
      }
    }
  }

  @override
  void initState() {
    forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double returnHeight() {
      if (Sizer.calculateVertical(context, 60) > 45) {
        return Sizer.calculateVertical(context, 60);
      } else {
        return 45;
      }
    }

    double returnMaxHeight() {
      if (Sizer.calculateVertical(context, 100) <= 50 &&
          Sizer.calculateVertical(context, 100) > 45) {
        return Sizer.calculateVertical(context, 100);
      } else if (Sizer.calculateVertical(context, 100) >= 50) {
        return 50;
      } else {
        return 46;
      }
    }

    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordStates>(
      bloc: forgotPasswordBloc,
      builder: (context, state) {
        if (state is ForgotPasswordSuccessState) {
          log(state.success.toString());
          emailController.clear();
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            _showSuccessAlert(
                "Email enviado com sucesso! Verifique sua caixa de entrada.");
          });
          forgotPasswordBloc
              .add(CleanStateEvent(state: ForgotPasswordInitialState()));
        }

        if (state is ForgotPasswordErrorState) {
          log(state.message);
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            _showErrorAlert(state.message);
          });
          forgotPasswordBloc
              .add(CleanStateEvent(state: ForgotPasswordInitialState()));
        }

        return forgotPasswordBloc.state is ForgotPasswordLoadingState
            ? const LoadingPage()
            : ResponsiveLayout(
                mobile: Scaffold(
                  body: SizedBox(
                    height: size.height,
                    width: size.width,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: Sizer.calculateVertical(context, 180),
                              bottom: Sizer.calculateVertical(context, 20),
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        Sizer.calculateHorizontal(context, 200),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          ResponsiveTextWidget(
                                            text: "Recuperação de Senha",
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.w900,
                                                ),
                                            maxLines: 2,
                                            maxFontSize: 37,
                                            minFontSize: 20,
                                            textScaleFactor: 1.5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: Sizer.calculateVertical(context, 60),
                                      bottom:
                                          Sizer.calculateVertical(context, 50),
                                    ),
                                    child: AppWebFieldWidget(
                                      constraints: BoxConstraints(
                                        minHeight: 35,
                                        maxHeight: returnMaxHeight(),
                                      ),
                                      fieldSemantic: "Campo de texto do email.",
                                      hintSemantic: "email",
                                      controller: emailController,
                                      onError: emailError,
                                      hint: "Digite seu email",
                                      label: "Email",
                                      heigth: returnHeight(),
                                      width: Sizer.calculateHorizontal(
                                          context, 200),
                                    ),
                                  ),
                                  ForgotPasswordButtonComponent(
                                    sendEmail: () => _validateForm(formKey),
                                  ),
                                ],
                              ),
                            ),
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
                        ForgotPasswordLogoBackgroundComponent(size: size),
                        SingleChildScrollView(
                          child: SizedBox(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: Sizer.calculateHorizontal(context, 40),
                                  top: Sizer.calculateVertical(context, 80),
                                  bottom: Sizer.calculateVertical(context, 20),
                                ),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Sizer.calculateHorizontal(
                                            context, 100),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            children: [
                                              ResponsiveTextWidget(
                                                text: "Recuperação de Senha",
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                maxLines: 2,
                                                maxFontSize: 37,
                                                minFontSize: 27,
                                                textScaleFactor: 1.5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: Sizer.calculateVertical(
                                              context, 60),
                                          bottom: Sizer.calculateVertical(
                                              context, 50),
                                        ),
                                        child: AppWebFieldWidget(
                                          constraints: BoxConstraints(
                                            minHeight: 35,
                                            maxHeight: returnMaxHeight(),
                                          ),
                                          fieldSemantic:
                                              "Campo de texto do email.",
                                          hintSemantic: "email",
                                          controller: emailController,
                                          onError: emailError,
                                          hint: "Digite seu email",
                                          label: "Email",
                                          heigth: returnHeight(),
                                          width: Sizer.calculateHorizontal(
                                              context, 100),
                                        ),
                                      ),
                                      ForgotPasswordButtonComponent(
                                        sendEmail: () => _validateForm(formKey),
                                      ),
                                    ],
                                  ),
                                ),
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
