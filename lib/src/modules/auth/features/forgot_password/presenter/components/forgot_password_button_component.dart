import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

class ForgotPasswordButtonComponent extends StatelessWidget {
  final Function sendEmail;
  const ForgotPasswordButtonComponent({Key? key, required this.sendEmail})
      : super(key: key);

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
      height: Sizer.calculateVertical(context, 140),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 35,
              maxHeight: returnMaxHeight(),
            ),
            child: SizedBox(
              height: returnHeight(),
              width: Sizer.calculateHorizontal(context, 100),
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
                  onPressed: () => sendEmail(),
                  child: ResponsiveTextWidget(
                    text: "Enviar",
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                    hintSemantics: "Enviar",
                    tooltipSemantics: "Enviar",
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            focusColor: AppColors.transparent,
            hoverColor: AppColors.transparent,
            splashColor: AppColors.transparent,
            highlightColor: AppColors.transparent,
            onTap: () => context.push("${RouteKeys.auth}${RouteKeys.login}"),
            child: ResponsiveTextWidget(
              text: "Voltar",
              selectable: false,
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.greyBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
              hintSemantics: "ResponsiveTextWidget",
              tooltipSemantics: "ResponsiveTextWidget",
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
