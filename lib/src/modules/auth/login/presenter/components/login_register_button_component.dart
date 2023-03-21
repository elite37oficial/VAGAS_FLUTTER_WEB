import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class LoginRegisterButtonComponent extends StatelessWidget {
  final double width;
  const LoginRegisterButtonComponent({Key? key, this.width = 150})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 50,
        maxHeight: Sizer.calculateVertical(context, 180) >= 51
            ? Sizer.calculateVertical(context, 180)
            : 51,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          returnDivider(
            context: context,
            width: Sizer.calculateHorizontal(context, width),
          ),
          GestureDetector(
            onTap: () {},
            child: AutoSizeText.rich(
              maxFontSize: 16,
              minFontSize: 12,
              TextSpan(
                  text: "Não tem uma conta? ",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                  children: [
                    TextSpan(
                      text: "Cadastre-se aqui",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.greyBlue,
                            fontWeight: FontWeight.w700,
                          ),
                    )
                  ]),
            ),
          ),
          returnDivider(
            context: context,
            width: Sizer.calculateHorizontal(context, width),
          ),
          SizedBox(
            width: Sizer.calculateHorizontal(context, width),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SocialCircleButtonWidget(
                  height: Sizer.calculateVertical(context, 70),
                  width: Sizer.calculateVertical(context, 70),
                  backgroundColor: AppColors.blue,
                  onTap: () {},
                  hint: "Linkedin Button",
                  tooltip: "Linkedin Button",
                  widget: FaIcon(
                    FontAwesomeIcons.linkedinIn,
                    color: AppColors.white,
                    size: Sizer.calculateVertical(context, 40),
                  ),
                ),
                SocialCircleButtonWidget(
                  height: Sizer.calculateVertical(context, 70),
                  width: Sizer.calculateVertical(context, 70),
                  backgroundColor: AppColors.accentBlue,
                  onTap: () {},
                  hint: "Facebook Button",
                  tooltip: "Facebook Button",
                  widget: FaIcon(
                    FontAwesomeIcons.facebookF,
                    color: AppColors.white,
                    size: Sizer.calculateVertical(context, 40),
                  ),
                ),
                SocialCircleButtonWidget(
                  height: Sizer.calculateVertical(context, 70),
                  width: Sizer.calculateVertical(context, 70),
                  backgroundColor: AppColors.white,
                  onTap: () {},
                  hint: "Google Button",
                  tooltip: "Google Button",
                  widget: FaIcon(
                    FontAwesomeIcons.google,
                    size: Sizer.calculateVertical(context, 40),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

returnDivider({required BuildContext context, required double width}) {
  return SizedBox(
    width: width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: width * 0.47,
          child: const Divider(
            thickness: 1.5,
            color: AppColors.grey,
          ),
        ),
        ResponsiveTextWidget(
          text: "OU",
          maxLines: 1,
          hintSemantics: "or",
          tooltipSemantics: "or",
          maxFontSize: 14,
          minFontSize: 10,
          textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.grey,
              ),
        ),
        SizedBox(
          width: width * 0.47,
          child: const Divider(
            thickness: 1.5,
            color: AppColors.grey,
          ),
        ),
      ],
    ),
  );
}
