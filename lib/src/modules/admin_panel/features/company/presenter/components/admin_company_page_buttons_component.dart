import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class AdminCompanyPageButtonsComponent extends StatelessWidget {
  final Function changePage;
  final int actualPage;
  final int totalPages;
  const AdminCompanyPageButtonsComponent(
      {Key? key,
      required this.changePage,
      required this.actualPage,
      required this.totalPages})
      : super(key: key);

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
                onPressed:
                    actualPage <= 1 ? null : () => changePage(actualPage - 1),
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
              ResponsiveTextWidget(
                text: "$actualPage de $totalPages",
                maxLines: 1,
                hintSemantics: "páginas",
                tooltipSemantics: "páginas",
              ),
              const Spacer(),
              PageButtonWidget(
                onPressed: actualPage >= totalPages
                    ? null
                    : () => changePage(actualPage + 1),
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
