import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class AdminCompanyHeaderFilterComponent extends StatelessWidget {
  final Size size;
  const AdminCompanyHeaderFilterComponent({Key? key, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      color: AppColors.white,
      elevation: 3,
      child: SizedBox(
        width: size.width * 0.7,
        height: Sizer.calculateVertical(context, 50) <= 35
            ? 35
            : Sizer.calculateVertical(context, 50),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: SizedBox(
                width: size.width * 0.7,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: Sizer.calculateHorizontal(context, 10) > 35
                            ? 35
                            : Sizer.calculateHorizontal(context, 10),
                      ),
                      child: ResponsiveTextWidget(
                        text: "Empresa",
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        hintSemantics: "empresa",
                        tooltipSemantics: "empresa",
                      ),
                    ),
                    const Icon(
                      Icons.arrow_downward_rounded,
                      color: AppColors.black,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: SizedBox(
                width: size.width * 0.7,
                child: Align(
                  alignment: Alignment.center,
                  child: ResponsiveTextWidget(
                    text: "Descrição",
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    hintSemantics: "descrição",
                    tooltipSemantics: "descrição",
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: SizedBox(
                width: size.width * 0.7,
                child: Center(
                  child: ResponsiveTextWidget(
                    text: "Ações",
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    hintSemantics: "ações",
                    tooltipSemantics: "ações",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
