import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class CreateDataJobPage extends StatefulWidget {
  final Function changePage;
  const CreateDataJobPage({Key? key, required this.changePage}) : super(key: key);

  @override
  State<CreateDataJobPage> createState() => _CreateDataJobPageState();
}

class _CreateDataJobPageState extends State<CreateDataJobPage> {
  TextEditingController menuController = TextEditingController();

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
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
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                            maxLines: 2,
                            maxFontSize: 32,
                            minFontSize: 26,
                            textAlign: TextAlign.left,
                            hintSemantics: "Contrate desenvolvedores Flutter.",
                            tooltipSemantics:
                                "Contrate desenvolvedores Flutter.",
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
                      textStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
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
                    semantics: "empresas",
                    height: Sizer.calculateVertical(context, 55) >= 36
                        ? Sizer.calculateVertical(context, 55)
                        : 36,
                    listItens: [
                      DropdownMenuItem(
                        value: "Teste A",
                        child: ResponsiveTextWidget(text: "Teste A"),
                      ),
                      DropdownMenuItem(
                        value: "Teste B",
                        child: ResponsiveTextWidget(text: "Teste B"),
                      ),
                    ],
                    error: false,
                    onChanged: (value) => menuController.text = value ?? "",
                    label: "Empresa",
                    controller: menuController,
                    hint: "Selecione a empresa para qual você está contratando",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: AppMenuDropDownWidget(
                      semantics: "Nível",
                      height: Sizer.calculateVertical(context, 55) >= 36
                          ? Sizer.calculateVertical(context, 55)
                          : 36,
                      listItens: [
                        DropdownMenuItem(
                          value: "Teste A",
                          child: ResponsiveTextWidget(text: "Teste A"),
                        ),
                        DropdownMenuItem(
                          value: "Teste B",
                          child: ResponsiveTextWidget(text: "Teste B"),
                        ),
                      ],
                      error: false,
                      onChanged: (value) => menuController.text = value ?? "",
                      label: "Nível",
                      controller: menuController,
                      hint: "Selecione o nível para sau vaga",
                    ),
                  ),
                  AppMenuDropDownWidget(
                    semantics: "local de trabalho",
                    height: Sizer.calculateVertical(context, 55) >= 36
                        ? Sizer.calculateVertical(context, 55)
                        : 36,
                    listItens: [
                      DropdownMenuItem(
                        value: "Teste A",
                        child: ResponsiveTextWidget(text: "Teste A"),
                      ),
                      DropdownMenuItem(
                        value: "Teste B",
                        child: ResponsiveTextWidget(text: "Teste B"),
                      ),
                    ],
                    error: false,
                    onChanged: (value) => menuController.text = value ?? "",
                    label: "Tipo de local de trabalho",
                    controller: menuController,
                    hint: "Selecione o tipo de local de trabalho",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: AppMenuDropDownWidget(
                      semantics: "tipo de vaga",
                      height: Sizer.calculateVertical(context, 55) >= 36
                          ? Sizer.calculateVertical(context, 55)
                          : 36,
                      listItens: [
                        DropdownMenuItem(
                          value: "Teste A",
                          child: ResponsiveTextWidget(text: "Teste A"),
                        ),
                        DropdownMenuItem(
                          value: "Teste B",
                          child: ResponsiveTextWidget(text: "Teste B"),
                        ),
                      ],
                      error: false,
                      onChanged: (value) => menuController.text = value ?? "",
                      label: "Tipo de vaga",
                      controller: menuController,
                      hint: "Selecione o tipo de vaga",
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FilledButtonWidget(
                  height: Sizer.calculateVertical(context, 55) >= 36
                      ? Sizer.calculateVertical(context, 55)
                      : 36,
                  width: Sizer.calculateHorizontal(context, 500),
                  onPressed: () => widget.changePage(1),
                  tooltip: "tooltip",
                  hintSemantics: "hintSemantics",
                  child: ResponsiveTextWidget(
                    text: "Continuar",
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                        ),
                    hintSemantics: "Continuar",
                    tooltipSemantics: "Continuar",
                    maxLines: 1,
                    maxFontSize: 22,
                    minFontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
