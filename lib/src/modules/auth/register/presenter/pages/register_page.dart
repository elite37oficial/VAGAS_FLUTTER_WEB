import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/entities/register_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/presenter/blocs/blocs/register_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/presenter/blocs/states/register_state.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/presenter/components/register_fields_component.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/presenter/components/register_logo_background_component.dart';
import 'package:vagas_flutter_web/src/shared/responsive/responsive_layout.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final companyController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  bool companyError = false;
  bool emailError = false;
  bool passwordError = false;
  bool repeatPasswordError = false;

  _validateRegisterForm(GlobalKey<FormState> formKey) {
    String email = emailController.text.replaceAll(" ", "");
    String company = companyController.text.trim();
    setState(() {
      companyError = company.isEmpty;

      emailError = email.isEmpty || email.length < 6 || !email.contains("@");

      passwordError =
          passwordController.text.isEmpty || passwordController.text.length < 8;

      repeatPasswordError =
          repeatPasswordController.text != passwordController.text;
    });

    if (formKey.currentState!.validate()) {
      if (!companyError &&
          !emailError &&
          !passwordError &&
          !repeatPasswordError) {
        context.read<RegisterBloc>().add(
              RegisterUserEvent(
                company: companyController.text,
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

    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        if (state is RegisterLoadingState) {
          return const LoadingPage();
        }
        if (state is RegisterErrorState) {
          log(state.message);
        }
        if (state is RegisterSuccessState) {
          RegisterUserEntity user = state.registerUser;
          log(user.userId);
          log(user.company);
          log(user.email);
          log(user.username);

          WidgetsBinding.instance.addPostFrameCallback((_) async {
            context.pushReplacement(RouteKeys.home);
          });
        }

        return ResponsiveLayout(
          desktop: Scaffold(
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
                                  text: "Cadastrar-se",
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
                        RegisterFieldsComponent(
                          formKey: formKey,
                          companyError: companyError,
                          emailError: emailError,
                          passwordError: passwordError,
                          repeatPasswordError: repeatPasswordError,
                          companyController: companyController,
                          emailController: emailController,
                          passwordController: passwordController,
                          repeatPasswordController: repeatPasswordController,
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
                                onPressed: () => _validateRegisterForm(formKey),
                                child: ResponsiveTextWidget(
                                  text: "Continuar",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                  hintSemantics: "Cadastro",
                                  tooltipSemantics: "Cadastro",
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
                              onTap: () {},
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
          mobile: Scaffold(
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RegisterLogoBackgroundComponent(size: size),
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
                                      text: "Cadastrar-se",
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
                            RegisterFieldsComponent(
                              formKey: formKey,
                              companyError: companyError,
                              emailError: emailError,
                              passwordError: passwordError,
                              repeatPasswordError: repeatPasswordError,
                              companyController: companyController,
                              emailController: emailController,
                              passwordController: passwordController,
                              repeatPasswordController:
                                  repeatPasswordController,
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
                                    onPressed: () =>
                                        _validateRegisterForm(formKey),
                                    child: ResponsiveTextWidget(
                                      text: "Continuar",
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                          ),
                                      hintSemantics: "Cadastro",
                                      tooltipSemantics: "Cadastro",
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
                                  onTap: () {},
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
