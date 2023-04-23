import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class CreatejobPage extends StatelessWidget {
  const CreatejobPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double returnHeight() {
      if (Sizer.calculateVertical(context, 60) > 35) {
        return Sizer.calculateVertical(context, 60);
      } else {
        return 35;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: SizedBox(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ResponsiveTextWidget(
                        text: "Contrate \ndesenvolvedores  Flutter.",
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                        maxLines: 2,
                        maxFontSize: 32,
                        minFontSize: 26,
                        textAlign: TextAlign.left,
                        hintSemantics: "Contrate desenvolvedores Flutter.",
                        tooltipSemantics: "Contrate desenvolvedores Flutter.",
                      ),
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () => Navigator.pop(context),
                          child: const Center(
                            child: Icon(
                              Icons.close_rounded,
                              size: 27,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ResponsiveTextWidget(
                  text: "Publique as vagas da sua empresa.",
                  hintSemantics: "Publique as vagas da sua empresa.",
                  tooltipSemantics: "Publique as vagas da sua empresa.",
                  maxFontSize: 18,
                  minFontSize: 14,
                  maxLines: 1,
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: StaticWebFieldWidget(
                  constraints: BoxConstraints(
                    minHeight: 35,
                    maxHeight: Sizer.calculateVertical(context, 55) >= 36
                        ? Sizer.calculateVertical(context, 55)
                        : 36,
                  ),
                  fieldSemantic: "Campo de texto do título.",
                  hintSemantic: "título",
                  controller: TextEditingController(),
                  onError: false,
                  hint: "Cargo para qual você está contratando",
                  label: "Título",
                  heigth: returnHeight(),
                  width: Sizer.calculateHorizontal(context, size.width),
                ),
              ),
              AppMenuDropDownWidget(
                listOptions: [
                  DropdownMenuItem(
                    value: "testeA",
                    child: ResponsiveTextWidget(text: "Teste A"),
                  ),
                ],
                constraints: BoxConstraints(
                  minHeight: 35,
                  maxHeight: Sizer.calculateVertical(context, 55) >= 36
                      ? Sizer.calculateVertical(context, 55)
                      : 36,
                ),
                fieldSemantic: "Menu de Empresas",
                hintSemantic: "Empresa",
                controller: TextEditingController(text: "testeA"),
                onError: false,
                hint: "Selecione a empresa para qual você está contratando",
                label: "Empresa",
                heigth: returnHeight(),
                width: Sizer.calculateHorizontal(context, size.width),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
