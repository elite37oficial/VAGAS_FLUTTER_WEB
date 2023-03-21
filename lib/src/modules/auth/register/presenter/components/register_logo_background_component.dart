import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class RegisterLogoBackgroundComponent extends StatelessWidget {
  final Size size;
  const RegisterLogoBackgroundComponent({Key? key, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greyBlue,
      height: size.height,
      width: Sizer.calculateHorizontal(context, 240),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ResponsiveTextWidget(
            text: "Bem-vindo anunciante!",
            textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
            maxLines: 1,
            maxFontSize: 48,
            minFontSize: 34,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Sizer.calculateVertical(context, 20),
              bottom: Sizer.calculateVertical(context, 80),
            ),
            child: ResponsiveTextWidget(
              text: "Anuncie vagas de Flutter aqui!",
              textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                  ),
              maxLines: 1,
              maxFontSize: 32,
              minFontSize: 24,
            ),
          ),
          SvgPicture.asset(
            AppImages.logoVagas,
            package: "vagas_design_system",
          )
        ],
      ),
    );
  }
}
