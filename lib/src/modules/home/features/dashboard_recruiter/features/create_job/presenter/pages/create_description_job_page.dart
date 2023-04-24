import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class CreateDescriptionjobPage extends StatefulWidget {
  final Function changePage;
  const CreateDescriptionjobPage({Key? key, required this.changePage}) : super(key: key);

  @override
  State<CreateDescriptionjobPage> createState() =>
      _CreateDescriptionjobPageState();
}

class _CreateDescriptionjobPageState extends State<CreateDescriptionjobPage> {
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
                            text: "3 de 3: Conte-nos mais sobre a vaga",
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                            maxLines: 2,
                            maxFontSize: 28,
                            minFontSize: 22,
                            textAlign: TextAlign.left,
                            hintSemantics:
                                "3 de 3: Conte-nos mais sobre a vaga",
                            tooltipSemantics:
                                "3 de 3: Conte-nos mais sobre a vaga",
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
                ],
              ),
              SizedBox(
                height: size.height * 0.5,
                child: Column(
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
                        fieldSemantic: "Digite a descrição",
                        hintSemantic: "Descrição*",
                        controller: TextEditingController(),
                        onError: false,
                        hint: "Digite a descrição",
                        label: "Descrição*",
                        heigth: returnHeight(),
                        width: Sizer.calculateHorizontal(context, size.width),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButtonWidget(
                      height: Sizer.calculateVertical(context, 55) >= 36
                          ? Sizer.calculateVertical(context, 55)
                          : 36,
                      width: Sizer.calculateHorizontal(context, 30),
                      onPressed: () => widget.changePage(1),
                      tooltip: "Voltar",
                      hintSemantics: "Voltar",
                      borderColor: AppColors.greyBlue,
                      secundaryColor: AppColors.greyBlue,
                      primaryColor: AppColors.white,
                      child: ResponsiveTextWidget(
                        text: "Voltar",
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.greyBlue,
                                  fontWeight: FontWeight.w700,
                                ),
                        hintSemantics: "Voltar",
                        tooltipSemantics: "Voltar",
                        maxLines: 1,
                        maxFontSize: 22,
                        minFontSize: 18,
                      ),
                    ),
                    FilledButtonWidget(
                      height: Sizer.calculateVertical(context, 55) >= 36
                          ? Sizer.calculateVertical(context, 55)
                          : 36,
                      width: Sizer.calculateHorizontal(context, 30),
                      onPressed: () {},
                      tooltip: "Publicar",
                      hintSemantics: "Publicar",
                      child: ResponsiveTextWidget(
                        text: "Publicar",
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                        hintSemantics: "Publicar",
                        tooltipSemantics: "Publicar",
                        maxLines: 1,
                        maxFontSize: 22,
                        minFontSize: 18,
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
