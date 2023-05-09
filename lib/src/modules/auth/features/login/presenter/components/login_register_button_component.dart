import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

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
          InkWell(
            splashColor: AppColors.transparent,
            highlightColor: AppColors.transparent,
            focusColor: AppColors.transparent,
            hoverColor: AppColors.transparent,
            onTap: () => context.push("${RouteKeys.auth}${RouteKeys.register}"),
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
