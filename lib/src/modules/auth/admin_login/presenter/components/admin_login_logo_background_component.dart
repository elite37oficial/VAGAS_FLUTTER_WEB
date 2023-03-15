import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class AdminLoginLogoBackgroundComponent extends StatelessWidget {
  final Size size;
  const AdminLoginLogoBackgroundComponent({Key? key, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greyBlue,
      height: size.height,
      width: Sizer.calculateHorizontal(context, 240),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppImages.backgroundIcons,
              fit: BoxFit.scaleDown,
              height: size.height,
              package: "vagas_design_system",
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60, right: 120),
              child: ResponsiveTextWidget(
                text: "Elite",
                maxLines: 1,
                textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 50,
                    ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 120),
              child: ResponsiveTextWidget(
                text: "Vagas",
                maxLines: 1,
                textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 50,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
