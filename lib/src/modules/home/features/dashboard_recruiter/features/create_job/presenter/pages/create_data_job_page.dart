import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class CreateDataJobPage extends StatefulWidget {
  final Function changePage;
  final TextEditingController enterpriseController;
  final TextEditingController localController;
  final TextEditingController typeJobController;
  final TextEditingController levelController;
  final TextEditingController titleController;
  const CreateDataJobPage({
    Key? key,
    required this.changePage,
    required this.enterpriseController,
    required this.levelController,
    required this.localController,
    required this.typeJobController,
    required this.titleController,
  }) : super(key: key);

  @override
  State<CreateDataJobPage> createState() => _CreateDataJobPageState();
}

class _CreateDataJobPageState extends State<CreateDataJobPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool titleError = false;
  bool levelError = false;
  bool localError = false;
  bool typeJobError = false;
  bool enterpriseError = false;

  List<DropdownMenuItem<String>> typeJob = [];

  _getTypeJob() async {
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      typeJob = [];
    });
  }

  _validateForm(formKey) {
    setState(() {
      localError = widget.localController.text.isEmpty;
      enterpriseError = widget.enterpriseController.text.isEmpty;

      typeJobError = widget.typeJobController.text.isEmpty;

      levelError = widget.levelController.text.isEmpty;
      titleError = widget.titleController.text.isEmpty ||
          widget.titleController.text.length < 6;
    });

    if (formKey.currentState!.validate()) {
      if (!localError &&
          !titleError &&
          !levelError &&
          !typeJobError &&
          !enterpriseError &&
          !localError) {
        widget.changePage(1);
      }
    }
  }

  @override
  void initState() {
    _getTypeJob();
    super.initState();
  }

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
          child: Form(
            key: formKey,
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
                              hintSemantics:
                                  "Contrate desenvolvedores Flutter.",
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
                        maxLength: 50,
                        constraints: BoxConstraints(
                          minHeight: 35,
                          maxHeight: Sizer.calculateVertical(context, 55) >= 36
                              ? Sizer.calculateVertical(context, 55)
                              : 36,
                        ),
                        fieldSemantic: "Campo de texto do título.",
                        hintSemantic: "título",
                        controller: widget.titleController,
                        onError: titleError,
                        onChanged: (_) => setState(() {
                          titleError = widget.titleController.text.isEmpty ||
                              widget.titleController.text.length < 4;
                        }),
                        hint: "Cargo para qual você está contratando",
                        label: "Título",
                        height: returnHeight(),
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
                      error: enterpriseError,
                      onChanged: (value) => setState(() {
                        widget.enterpriseController.text = value ?? "";

                        enterpriseError =
                            widget.enterpriseController.text.isEmpty;
                      }),
                      label: "Empresa",
                      controller: widget.enterpriseController,
                      hint:
                          "Selecione a empresa para qual você está contratando",
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
                            value: "Júnior",
                            child: ResponsiveTextWidget(text: "Júnior"),
                          ),
                          DropdownMenuItem(
                            value: "Pleno",
                            child: ResponsiveTextWidget(text: "Pleno"),
                          ),
                          DropdownMenuItem(
                            value: "Sênior",
                            child: ResponsiveTextWidget(text: "Sênior"),
                          ),
                        ],
                        error: levelError,
                        onChanged: (value) => setState(() {
                          widget.levelController.text = value ?? "";

                          levelError = widget.levelController.text.isEmpty;
                        }),
                        label: "Nível",
                        controller: widget.levelController,
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
                          value: "Remoto",
                          child: ResponsiveTextWidget(text: "Remoto"),
                        ),
                        DropdownMenuItem(
                          value: "Presencial",
                          child: ResponsiveTextWidget(text: "Presencial"),
                        ),
                        DropdownMenuItem(
                          value: "Híbrido",
                          child: ResponsiveTextWidget(text: "Híbrido"),
                        ),
                      ],
                      error: localError,
                      onChanged: (value) => setState(() {
                        widget.localController.text = value ?? "";

                        localError = widget.localController.text.isEmpty;
                      }),
                      label: "Tipo de local de trabalho",
                      controller: widget.localController,
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
                            value: "Tempo Integral",
                            child: ResponsiveTextWidget(text: "Tempo Integral"),
                          ),
                          DropdownMenuItem(
                            value: "Tempo Parcial",
                            child: ResponsiveTextWidget(text: "Tempo Parcial"),
                          ),
                          DropdownMenuItem(
                            value: "Outro",
                            child: ResponsiveTextWidget(text: "Outro"),
                          ),
                        ],
                        error: typeJobError,
                        onChanged: (value) => setState(() {
                          widget.typeJobController.text = value ?? "";

                          typeJobError = widget.typeJobController.text.isEmpty;
                        }),
                        label: "Tipo de vaga",
                        controller: widget.typeJobController,
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
                    onPressed: () => _validateForm(formKey),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
