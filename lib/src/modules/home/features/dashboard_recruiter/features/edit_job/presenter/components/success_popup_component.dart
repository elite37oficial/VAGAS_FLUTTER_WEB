import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';

class SuccessPopupComponent extends StatelessWidget {
  const SuccessPopupComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SvgPicture.asset(
                  AppImages.successFilled,
                  package: "vagas_design_system",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ResponsiveTextWidget(
                  text: "Concluído com Sucesso!",
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                  maxFontSize: 20,
                  minFontSize: 14,
                  maxLines: 1,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, top: 5),
                      child: FilledButtonWidget(
                        onPressed: () {},
                        height: 35,
                        width: size.width * 0.2,
                        hintSemantics: "Nova Vaga",
                        tooltip: "Nova Vaga",
                        child: ResponsiveTextWidget(
                          text: "Nova Vaga",
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.white),
                          maxLines: 1,
                          maxFontSize: 26,
                          minFontSize: 18,
                          selectable: false,
                          hintSemantics: "Nova Vaga",
                          tooltipSemantics: "Nova Vaga",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, top: 5),
                      child: OutlinedButtonWidget(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        height: 35,
                        width: size.width * 0.2,
                        hintSemantics: "Finalizar",
                        tooltip: "Finalizar",
                        child: ResponsiveTextWidget(
                          text: "Finalizar",
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.greyBlue),
                          maxLines: 1,
                          maxFontSize: 26,
                          minFontSize: 18,
                          selectable: false,
                          hintSemantics: "Finalizar",
                          tooltipSemantics: "Finalizar",
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
