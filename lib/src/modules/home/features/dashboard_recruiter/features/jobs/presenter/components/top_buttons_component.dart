import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class TopButtonsComponent extends StatelessWidget {
  final Function showCreatejobPopup;
  const TopButtonsComponent({Key? key, required this.showCreatejobPopup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PageButtonWidget(
            onPressed: () {},
            height: Sizer.calculateVertical(context, 40) <= 20
                ? 20
                : Sizer.calculateVertical(context, 40),
            width: 100,
            tooltip: "filtros",
            hintSemantics: "filtros",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.filter_list_rounded,
                  color: AppColors.black,
                ),
                ResponsiveTextWidget(
                  text: "Filtros",
                  selectable: false,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                  hintSemantics: "filtros",
                  tooltipSemantics: "filtros",
                  maxLines: 1,
                  maxFontSize: 12,
                  minFontSize: 8,
                ),
              ],
            ),
          ),
          Semantics(
            button: true,
            tooltip: "nova",
            hint: "nova",
            enabled: true,
            child: Tooltip(
              message: "nova",
              child: SizedBox(
                height: Sizer.calculateVertical(context, 40) <= 20
                    ? 20
                    : Sizer.calculateVertical(context, 40),
                width: 100,
                child: ElevatedButton(
                  onPressed: () => showCreatejobPopup(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greyBlue,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.add_rounded,
                        color: AppColors.white,
                      ),
                      const Spacer(),
                      ResponsiveTextWidget(
                        text: "Nova",
                        selectable: false,
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                ),
                        hintSemantics: "nova",
                        tooltipSemantics: "nova",
                        maxLines: 1,
                        maxFontSize: 12,
                        minFontSize: 8,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
