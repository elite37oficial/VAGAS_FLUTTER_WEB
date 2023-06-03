import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class TopButtonsComponent extends StatelessWidget {
  const TopButtonsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40, top: 60),
              child: ResponsiveTextWidget(
                text: "Usuários",
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w700),
                hintSemantics: "usuários",
                tooltipSemantics: "usuários",
                maxLines: 1,
                maxFontSize: 32,
                minFontSize: 27,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Semantics(
              button: true,
              tooltip: "criar",
              hint: "criar",
              enabled: true,
              child: Tooltip(
                message: "criar",
                child: SizedBox(
                  height: Sizer.calculateVertical(context, 40) <= 20
                      ? 20
                      : Sizer.calculateVertical(context, 40),
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {},
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
                          text: "Criar",
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                          hintSemantics: "criar",
                          tooltipSemantics: "criar",
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
          ),
        ],
      ),
    );
  }
}
