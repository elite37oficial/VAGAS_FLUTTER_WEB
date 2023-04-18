import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/helpers/masks/input_masks_helper.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class RegisterFieldsComponent extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final double width;
  final bool nameError;
  final bool phoneError;
  final bool emailError;
  final bool passwordError;
  final bool repeatPasswordError;
  final GlobalKey<FormState> formKey;
  const RegisterFieldsComponent({
    Key? key,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.formKey,
    required this.phoneError,
    required this.nameError,
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
              fieldSemantic: "Campo de texto do nome.",
              hintSemantic: "name",
              controller: nameController,
              onError: nameError,
              hint: "Digite o seu nome",
              label: "Nome",
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
              fieldSemantic: "Campo de texto do telefone.",
              hintSemantic: "phone",
              controller: phoneController,
              onError: phoneError,
              hint: "Digite o seu número de telefone",
              label: "Telefone",
              inputFormatters: [InputMasksHelper.cellPhone],
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
