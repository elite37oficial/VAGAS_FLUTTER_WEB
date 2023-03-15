import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class AdminLoginSocialButtonsMobileComponent extends StatelessWidget {
  const AdminLoginSocialButtonsMobileComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizer.calculateVertical(context, 200),
      width: Sizer.calculateHorizontal(context, 250),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: Sizer.calculateVertical(context, 50),
            width: Sizer.calculateHorizontal(context, 250),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.greyBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: Sizer.calculateVertical(context, 30),
                    width: Sizer.calculateVertical(context, 30),
                    child: const FaIcon(
                      FontAwesomeIcons.linkedinIn,
                      size: 27,
                      color: AppColors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ResponsiveTextWidget(
                      text: "Linkedin",
                      textStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: AppColors.white,
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Sizer.calculateVertical(context, 50),
            width: Sizer.calculateHorizontal(context, 250),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: Sizer.calculateVertical(context, 30),
                    width: Sizer.calculateVertical(context, 30),
                    child: const FaIcon(
                      FontAwesomeIcons.google,
                      color: AppColors.black,
                      size: 27,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ResponsiveTextWidget(
                      text: "Google",
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Sizer.calculateVertical(context, 50),
            width: Sizer.calculateHorizontal(context, 250),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.accentBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: Sizer.calculateVertical(context, 30),
                    width: Sizer.calculateVertical(context, 30),
                    child: const FaIcon(
                      FontAwesomeIcons.facebookF,
                      size: 27,
                      color: AppColors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ResponsiveTextWidget(
                      text: "Facebook",
                      textStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: AppColors.white,
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
