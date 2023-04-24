import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class CreateContactjobPage extends StatefulWidget {
  final Function changePage;
  const CreateContactjobPage({Key? key, required this.changePage})
      : super(key: key);

  @override
  State<CreateContactjobPage> createState() => _CreateContactjobPageState();
}

class _CreateContactjobPageState extends State<CreateContactjobPage> {
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
                            text:
                                "2 de 3: Formas do canditato entrar \nem contato",
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
                                "2 de 3: Formas do canditato entrar em contato",
                            tooltipSemantics:
                                "2 de 3: Formas do canditato entrar \nem contato",
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        fieldSemantic: "Digite o número do whatsapp",
                        hintSemantic: "Whatsapp",
                        controller: TextEditingController(),
                        onError: false,
                        hint: "Digite o número do whatsapp",
                        label: "Whatsapp",
                        heigth: returnHeight(),
                        width: Sizer.calculateHorizontal(context, size.width),
                      ),
                    ),
                    StaticWebFieldWidget(
                      constraints: BoxConstraints(
                        minHeight: 35,
                        maxHeight: Sizer.calculateVertical(context, 55) >= 36
                            ? Sizer.calculateVertical(context, 55)
                            : 36,
                      ),
                      fieldSemantic: "Campo de texto do Email.",
                      hintSemantic: "Email",
                      controller: TextEditingController(),
                      onError: false,
                      hint: "Digite o Email de contato",
                      label: "Email",
                      heigth: returnHeight(),
                      width: Sizer.calculateHorizontal(context, size.width),
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
                        fieldSemantic: "Campo de texto do Link.",
                        hintSemantic: "Link",
                        controller: TextEditingController(),
                        onError: false,
                        hint: "Digite o Link de contato",
                        label: "Link",
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
                      onPressed: () => widget.changePage(0),
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
                      onPressed: () => widget.changePage(2),
                      tooltip: "tooltip",
                      hintSemantics: "hintSemantics",
                      child: ResponsiveTextWidget(
                        text: "Continuar",
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
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
