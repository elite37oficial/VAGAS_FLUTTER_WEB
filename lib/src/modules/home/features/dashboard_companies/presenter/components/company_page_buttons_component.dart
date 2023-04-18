import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class CompanyPageButtonsComponent extends StatelessWidget {
  const CompanyPageButtonsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      color: AppColors.white,
      elevation: 3,
      child: SizedBox(
        height: Sizer.calculateVertical(context, 50) <= 35
            ? 35
            : Sizer.calculateVertical(context, 50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PageButtonWidget(
                onPressed: null,
                height: Sizer.calculateVertical(context, 35) <= 20
                    ? 20
                    : Sizer.calculateVertical(context, 35),
                width: 90,
                tooltip: "anterior",
                hintSemantics: "anterior",
                child: const ResponsiveTextWidget(
                  text: "Anterior",
                  maxLines: 1,
                  hintSemantics: "anterior",
                  tooltipSemantics: "anterior",
                ),
              ),
              const Spacer(),
              const ResponsiveTextWidget(
                text: "1 de 10",
                maxLines: 1,
                hintSemantics: "páginas",
                tooltipSemantics: "páginas",
              ),
              const Spacer(),
              PageButtonWidget(
                onPressed: () {},
                height: Sizer.calculateVertical(context, 35) <= 20
                    ? 20
                    : Sizer.calculateVertical(context, 35),
                width: 90,
                tooltip: "próximo",
                hintSemantics: "próximo",
                child: const ResponsiveTextWidget(
                  text: "Próximo",
                  maxLines: 1,
                  hintSemantics: "próximo",
                  tooltipSemantics: "próximo",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
