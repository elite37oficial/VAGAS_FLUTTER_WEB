import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class AdminLoginSocialButtonsComponent extends StatelessWidget {
  const AdminLoginSocialButtonsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizer.calculateHorizontal(context, 120),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SocialCircleButtonWidget(
            height: Sizer.calculateVertical(context, 90),
            width: Sizer.calculateVertical(context, 90),
            backgroundColor: AppColors.blue,
            onTap: () {},
            widget: const FaIcon(
              FontAwesomeIcons.linkedinIn,
              size: 37,
              color: AppColors.white,
            ),
            hint: "Linkedin",
            tooltip: "Botão Linkedin",
          ),
          SocialCircleButtonWidget(
            height: Sizer.calculateVertical(context, 90),
            width: Sizer.calculateVertical(context, 90),
            backgroundColor: AppColors.white,
            onTap: () {},
            widget: const FaIcon(
              FontAwesomeIcons.google,
              size: 37,
            ),
            hint: "Google",
            tooltip: "Botão Google",
          ),
          SocialCircleButtonWidget(
            height: Sizer.calculateVertical(context, 90),
            width: Sizer.calculateVertical(context, 90),
            backgroundColor: AppColors.accentBlue,
            onTap: () {},
            widget: const FaIcon(
              FontAwesomeIcons.facebookF,
              size: 37,
              color: AppColors.white,
            ),
            hint: "Facebook",
            tooltip: "Botão Facebook",
          ),
        ],
      ),
    );
  }
}
