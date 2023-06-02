import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/presenter/blocs/blocs/reset_password_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/presenter/components/reset_password_background_component.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

class ResetPasswordPage extends StatefulWidget {
  final String token;
  const ResetPasswordPage({Key? key, required this.token}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late ResetPasswordBloc resetPasswordBloc;

  TextEditingController passwordController = TextEditingController();
  bool passwordError = false;
  TextEditingController confirmController = TextEditingController();
  bool confirmError = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  _showSuccessAlert(String message) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) {
        return SuccessPopUpWidget.show(
          context: context,
          height: Sizer.calculateVertical(context, 250),
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
    setState(() {
      passwordError =
          passwordController.text.isEmpty || passwordController.text.length < 6;
      confirmError = confirmController.text != passwordController.text ||
          confirmController.text.isEmpty;
    });

    if (formKey.currentState!.validate()) {
      if (!confirmError && !passwordError) {
        passwordError = false;
        confirmError = false;

        resetPasswordBloc.add(
          DoResetPasswordEvent(
              password: passwordController.text, token: widget.token),
        );
      }
    }
  }

  @override
  void initState() {
    resetPasswordBloc = BlocProvider.of<ResetPasswordBloc>(context);
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

    return BlocBuilder<ResetPasswordBloc, ResetPasswordStates>(
      bloc: resetPasswordBloc,
      builder: (context, state) {
        if (state is ResetPasswordSuccessState) {
          log(state.message.toString());
          passwordController.clear();
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            _showSuccessAlert(
                "Senha alterada com sucesso! Faça o login usando a nova senha.");
          });
          resetPasswordBloc
              .add(CleanStateEvent(state: ResetPasswordInitialState()));
        }

        if (state is ResetPasswordErrorState) {
          log(state.message);
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            _showErrorAlert(state.message);
          });
          resetPasswordBloc
              .add(CleanStateEvent(state: ResetPasswordInitialState()));
        }

        return resetPasswordBloc.state is ResetPasswordLoadingState
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
                                            text: "Insira uma nova Senha",
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
                                    ),
                                    child: AppWebFieldWidget(
                                      constraints: BoxConstraints(
                                        minHeight: 35,
                                        maxHeight: returnMaxHeight(),
                                      ),
                                      fieldSemantic: "Campo de texto de senha.",
                                      hintSemantic: "senha",
                                      controller: passwordController,
                                      onError: passwordError,
                                      hint: "Digite sua senha",
                                      label: "Senha",
                                      isPassword: true,
                                      heigth: returnHeight(),
                                      width: Sizer.calculateHorizontal(
                                          context, 200),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: Sizer.calculateVertical(context, 20),
                                      bottom:
                                          Sizer.calculateVertical(context, 120),
                                    ),
                                    child: AppWebFieldWidget(
                                      constraints: BoxConstraints(
                                        minHeight: 35,
                                        maxHeight: returnMaxHeight(),
                                      ),
                                      fieldSemantic: "Campo de texto de senha.",
                                      hintSemantic: "email",
                                      controller: confirmController,
                                      onError: confirmError,
                                      hint: "Digite sua senha",
                                      label: "Repita a senha",
                                      isPassword: true,
                                      heigth: returnHeight(),
                                      width: Sizer.calculateHorizontal(
                                          context, 200),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: 35,
                                      maxHeight: returnMaxHeight(),
                                    ),
                                    child: SizedBox(
                                      height: returnHeight(),
                                      width: Sizer.calculateHorizontal(
                                          context, 100),
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
                                          onPressed: () =>
                                              _validateForm(formKey),
                                          child: ResponsiveTextWidget(
                                            text: "Enviar",
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                ),
                                            hintSemantics: "Enviar",
                                            tooltipSemantics: "Enviar",
                                            maxLines: 1,
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
                  ),
                ),
                desktop: Scaffold(
                  body: SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ResetPasswordLogoBackgroundComponent(size: size),
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
                                                text: "Insira uma nova Senha",
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
                                        ),
                                        child: AppWebFieldWidget(
                                          constraints: BoxConstraints(
                                            minHeight: 35,
                                            maxHeight: returnMaxHeight(),
                                          ),
                                          fieldSemantic:
                                              "Campo de texto de senha.",
                                          hintSemantic: "senha",
                                          controller: passwordController,
                                          onError: passwordError,
                                          hint: "Digite sua senha",
                                          label: "Senha",
                                          isPassword: true,
                                          heigth: returnHeight(),
                                          width: Sizer.calculateHorizontal(
                                              context, 100),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: Sizer.calculateVertical(
                                              context, 20),
                                          bottom: Sizer.calculateVertical(
                                              context, 120),
                                        ),
                                        child: AppWebFieldWidget(
                                          constraints: BoxConstraints(
                                            minHeight: 35,
                                            maxHeight: returnMaxHeight(),
                                          ),
                                          fieldSemantic:
                                              "Campo de texto de senha.",
                                          hintSemantic: "email",
                                          controller: confirmController,
                                          onError: confirmError,
                                          hint: "Digite sua senha",
                                          label: "Repita a senha",
                                          isPassword: true,
                                          heigth: returnHeight(),
                                          width: Sizer.calculateHorizontal(
                                              context, 100),
                                        ),
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minHeight: 35,
                                          maxHeight: returnMaxHeight(),
                                        ),
                                        child: SizedBox(
                                          height: returnHeight(),
                                          width: Sizer.calculateHorizontal(
                                              context, 100),
                                          child: ElevatedButtonTheme(
                                            data: ElevatedButtonThemeData(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor:
                                                    AppColors.greyBlue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                            ),
                                            child: ElevatedButton(
                                              onPressed: () =>
                                                  _validateForm(formKey),
                                              child: ResponsiveTextWidget(
                                                text: "Enviar",
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 20,
                                                    ),
                                                hintSemantics: "Enviar",
                                                tooltipSemantics: "Enviar",
                                                maxLines: 1,
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
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
