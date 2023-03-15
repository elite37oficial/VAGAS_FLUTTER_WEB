import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class AdminLoginFieldsComponent extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final double width;
  const AdminLoginFieldsComponent({
    Key? key,
    required this.emailController,
    required this.passwordController,
    this.width = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizer.calculateHorizontal(context, width),
      child: Column(
        children: [
          AppFieldWidget(
            fieldSemantic: "Campo de texto do email.",
            hintSemantic: "email",
            controller: emailController,
            hint: "Email",
            heigth: Sizer.calculateVertical(context, 60),
            width: Sizer.calculateHorizontal(context, width),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                  left: 15, top: 10, bottom: 10, right: 10),
              child: SvgPicture.asset(
                AppImages.emailIcon,
                height: Sizer.calculateVertical(context, 38),
                width: Sizer.calculateHorizontal(context, 38),
                package: "vagas_design_system",
              ),
            ),
          ),
          AppFieldWidget(
            fieldSemantic: "Campo de texto do senha.",
            hintSemantic: "password",
            controller: passwordController,
            hint: "Senha",
            heigth: Sizer.calculateVertical(context, 60),
            width: Sizer.calculateHorizontal(context, width),
            isPassword: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                  left: 15, top: 10, bottom: 10, right: 10),
              child: SvgPicture.asset(
                AppImages.lockIcon,
                height: Sizer.calculateVertical(context, 38),
                width: Sizer.calculateHorizontal(context, 38),
                package: "vagas_design_system",
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SelectionArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: AutoSizeText.rich(
                  maxLines: 1,
                  TextSpan(
                    text: "Esqueceu a senha? ",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.lightGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                    children: [
                      TextSpan(
                        text: "Recuperar",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
    );
  }
}
