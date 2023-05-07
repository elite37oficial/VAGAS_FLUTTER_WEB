import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class LoginFieldsComponent extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final double width;
  final bool emailError;
  final bool passwordError;
  final GlobalKey<FormState> formKey;
  const LoginFieldsComponent({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.emailError,
    required this.passwordError,
    this.width = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return SizedBox(
      width: Sizer.calculateHorizontal(context, width),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            AppWebFieldWidget(
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
              width: Sizer.calculateHorizontal(context, width),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: Sizer.calculateVertical(context, 30),
                bottom: 10,
              ),
              child: AppWebFieldWidget(
                constraints: BoxConstraints(
                  minHeight: 35,
                  maxHeight: returnMaxHeight(),
                ),
                fieldSemantic: "Campo de texto do senha.",
                hintSemantic: "password",
                controller: passwordController,
                onError: passwordError,
                hint: "Digite sua senha",
                label: "Senha",
                heigth: returnHeight(),
                width: Sizer.calculateHorizontal(context, width),
                isPassword: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: Sizer.calculateVertical(context, 20),
                  bottom: Sizer.calculateVertical(context, 70)),
              child: GestureDetector(
                onTap: () {},
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ResponsiveTextWidget(
                    text: "Esqueceu a senha?",
                    hintSemantics: "Forgot Password",
                    tooltipSemantics: "Forgot Password",
                    maxLines: 1,
                    maxFontSize: 16,
                    minFontSize: 12,
                    textAlign: TextAlign.left,
                    textStyle:
                        Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: AppColors.greyBlue,
                            ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
