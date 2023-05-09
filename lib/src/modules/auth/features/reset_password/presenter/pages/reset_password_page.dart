import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/presenter/blocs/blocs/reset_password_bloc.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late ResetPasswordBloc resetPasswordBloc;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool passwordError = false;
  bool confirmPasswordError = false;

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
          passwordController.text.isEmpty || passwordController.text.length < 8;
      confirmPasswordError = confirmPasswordController.text.isEmpty ||
          confirmPasswordController.text != passwordController.text;
    });

    if (formKey.currentState!.validate()) {
      if (!passwordError && !confirmPasswordError) {
        resetPasswordBloc.add(
          DoResetPasswordEvent(email: passwordController.text),
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
          log(state.message);
          passwordController.clear();
          confirmPasswordController.clear();
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            _showSuccessAlert("Senha alterada com sucesso!");
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
            : Scaffold(
                body: Form(
                  key: formKey,
                  child: SizedBox(
                    height: size.height,
                    width: size.width,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: Sizer.calculateHorizontal(context, 120),
                            right: Sizer.calculateHorizontal(context, 120),
                            top: 80,
                            bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: SvgPicture.asset(
                                  AppImages.logoVagas,
                                  color: AppColors.greyBlue,
                                  package: "vagas_design_system",
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Align(
                                alignment: Alignment.center,
                                child: ResponsiveTextWidget(
                                  text: "Insira a nova senha da sua conta.",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                  maxLines: 4,
                                  maxFontSize: 28,
                                  minFontSize: 24,
                                  textAlign: TextAlign.center,
                                  tooltipSemantics: "senha",
                                  hintSemantics: "senha",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: AppWebFieldWidget(
                                constraints: BoxConstraints(
                                  minHeight: 35,
                                  maxHeight: returnMaxHeight(),
                                ),
                                fieldSemantic: "Campo de texto do senha.",
                                hintSemantic: "senha",
                                controller: passwordController,
                                onError: passwordError,
                                hint: "Digite seu senha",
                                label: "Senha",
                                isPassword: true,
                                heigth: returnHeight(),
                                width: Sizer.calculateHorizontal(context, 800),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 80),
                              child: AppWebFieldWidget(
                                constraints: BoxConstraints(
                                  minHeight: 35,
                                  maxHeight: returnMaxHeight(),
                                ),
                                fieldSemantic: "Campo de texto do senha.",
                                hintSemantic: "senha",
                                controller: confirmPasswordController,
                                onError: confirmPasswordError,
                                hint: "Digite seu senha",
                                label: "Confirme a Senha",
                                isPassword: true,
                                heigth: returnHeight(),
                                width: Sizer.calculateHorizontal(context, 800),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: 35,
                                  maxHeight: returnMaxHeight(),
                                ),
                                child: SizedBox(
                                  height: returnHeight(),
                                  width:
                                      Sizer.calculateHorizontal(context, 180),
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
                                        text: "Salvar",
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                            ),
                                        hintSemantics: "Salvar",
                                        tooltipSemantics: "Salvar",
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: Sizer.calculateVertical(context, 120),
                                  bottom: Sizer.calculateVertical(context, 70)),
                              child: GestureDetector(
                                onTap: () => context.push(
                                    "${RouteKeys.auth}${RouteKeys.login}"),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: ResponsiveTextWidget(
                                    text: "Voltar",
                                    selectable: false,
                                    hintSemantics: "Voltar",
                                    tooltipSemantics: "Voltar",
                                    maxLines: 1,
                                    maxFontSize: 16,
                                    minFontSize: 12,
                                    textAlign: TextAlign.center,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: AppColors.greyBlue,
                                        ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
