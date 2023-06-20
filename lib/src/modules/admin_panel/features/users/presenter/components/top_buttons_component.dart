import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';

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
        ],
      ),
    );
  }
}
