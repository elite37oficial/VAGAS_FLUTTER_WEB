import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class RegisterFieldsComponent extends StatelessWidget {
  final TextEditingController companyController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final double width;
  final bool companyError;
  final bool emailError;
  final bool passwordError;
  final bool repeatPasswordError;
  final GlobalKey<FormState> formKey;
  const RegisterFieldsComponent({
    Key? key,
    required this.companyController,
    required this.emailController,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.formKey,
    required this.companyError,
    required this.emailError,
    required this.passwordError,
    required this.repeatPasswordError,
    this.width = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double returnHeight() {
      if (Sizer.calculateVertical(context, 60) > 35) {
        return Sizer.calculateVertical(context, 60);
      } else {
        return 35;
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
                maxHeight: Sizer.calculateVertical(context, 100) >= 36
                    ? Sizer.calculateVertical(context, 100)
                    : 36,
              ),
              fieldSemantic: "Campo de texto da empresa.",
              hintSemantic: "company",
              controller: companyController,
              onError: companyError,
              hint: "Digite o nome da sua Empresa",
              label: "Empresa",
              heigth: returnHeight(),
              width: Sizer.calculateHorizontal(context, width),
            ),
            SizedBox(
              height: Sizer.calculateVertical(context, 30),
            ),
            AppWebFieldWidget(
              constraints: BoxConstraints(
                minHeight: 35,
                maxHeight: Sizer.calculateVertical(context, 100) >= 36
                    ? Sizer.calculateVertical(context, 100)
                    : 36,
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
            SizedBox(
              height: Sizer.calculateVertical(context, 30),
            ),
            AppWebFieldWidget(
              constraints: BoxConstraints(
                minHeight: 35,
                maxHeight: Sizer.calculateVertical(context, 100) >= 36
                    ? Sizer.calculateVertical(context, 100)
                    : 36,
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
            SizedBox(
              height: Sizer.calculateVertical(context, 30),
            ),
            AppWebFieldWidget(
              constraints: BoxConstraints(
                minHeight: 35,
                maxHeight: Sizer.calculateVertical(context, 100) >= 36
                    ? Sizer.calculateVertical(context, 100)
                    : 36,
              ),
              fieldSemantic: "Campo de texto de repertir a senha.",
              hintSemantic: "password",
              controller: repeatPasswordController,
              onError: repeatPasswordError,
              hint: "Repita sua senha",
              label: "Repetir Senha",
              heigth: returnHeight(),
              width: Sizer.calculateHorizontal(context, width),
              isPassword: true,
            ),
          ],
        ),
      ),
    );
  }
}
