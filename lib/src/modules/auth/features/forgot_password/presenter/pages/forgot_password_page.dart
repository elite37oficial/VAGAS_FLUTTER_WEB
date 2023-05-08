import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/presenter/blocs/blocs/forgot_password_bloc.dart';
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
          log(state.message);
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
                                  const EdgeInsets.only(top: 30, bottom: 70),
                              child: Align(
                                alignment: Alignment.center,
                                child: ResponsiveTextWidget(
                                  text:
                                      "Insira o email para enviar o código de recuperação de senha.",
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
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 80),
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
                                        text: "Enviar",
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                            ),
                                        hintSemantics: "Senha",
                                        tooltipSemantics: "Senha",
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
                                onTap: () => context.pop(),
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
