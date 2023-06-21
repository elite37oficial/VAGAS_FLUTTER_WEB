import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class AdminCreateDescriptionjobComponent extends StatefulWidget {
  final Function changePage;
  final TextEditingController descriptionController;
  final Function createJob;
  const AdminCreateDescriptionjobComponent({
    Key? key,
    required this.changePage,
    required this.descriptionController,
    required this.createJob,
  }) : super(key: key);

  @override
  State<AdminCreateDescriptionjobComponent> createState() =>
      _AdminCreateDescriptionjobComponentState();
}

class _AdminCreateDescriptionjobComponentState
    extends State<AdminCreateDescriptionjobComponent> {
  bool descriptionError = false;

  GlobalKey<FormState> formKey = GlobalKey();

  _validateForm(formKey) {
    setState(() {
      descriptionError = widget.descriptionController.text.isEmpty ||
          widget.descriptionController.text.length < 5;
    });

    if (formKey.currentState!.validate()) {
      if (!descriptionError) {
        widget.createJob();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: SizedBox(
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
                      padding: const EdgeInsets.only(top: 30, bottom: 15),
                      child: SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () => Navigator.pop(context),
                                child: const Center(
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 22,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Sizer.calculateHorizontal(context, 70),
                            child: ResponsiveTextWidget(
                              text: "3 de 3: Conte-nos mais sobre a vaga",
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                              maxLines: 4,
                              maxFontSize: 28,
                              minFontSize: 22,
                              textAlign: TextAlign.left,
                              hintSemantics:
                                  "3 de 3: Conte-nos mais sobre a vaga",
                              tooltipSemantics:
                                  "3 de 3: Conte-nos mais sobre a vaga",
                            ),
                          ),
                        ],
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
                        child: BigStaticWebFieldWidget(
                          height: size.height * 0.45,
                          onError: descriptionError,
                          hint: "Digite sua descrição",
                          controller: widget.descriptionController,
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
                      OutlinedButtonWidget(
                        height: Sizer.calculateVertical(context, 55) >= 36
                            ? Sizer.calculateVertical(context, 55)
                            : 36,
                        width: Sizer.calculateHorizontal(context, 30),
                        onPressed: () => widget.changePage(1),
                        tooltip: "Voltar",
                        hintSemantics: "Voltar",
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
                        onPressed: () => _validateForm(formKey),
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
      ),
    );
  }
}
