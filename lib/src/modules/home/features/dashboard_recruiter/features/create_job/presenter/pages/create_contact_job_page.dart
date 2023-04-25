import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/helpers/masks/input_masks_helper.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class CreateContactjobPage extends StatefulWidget {
  final Function changePage;
  final TextEditingController phoneController;
  final TextEditingController linkController;
  final TextEditingController emailController;
  const CreateContactjobPage({
    Key? key,
    required this.changePage,
    required this.emailController,
    required this.linkController,
    required this.phoneController,
  }) : super(key: key);

  @override
  State<CreateContactjobPage> createState() => _CreateContactjobPageState();
}

class _CreateContactjobPageState extends State<CreateContactjobPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool phoneError = false;
  bool linkError = false;
  bool emailError = false;

  _validateForm(formKey) {
    setState(() {
      emailError = widget.emailController.text.isEmpty ||
          !widget.emailController.text.contains("@") ||
          !widget.emailController.text.contains(".") ||
          widget.emailController.text.length < 6;

      linkError = widget.linkController.text.isEmpty ||
          !widget.linkController.text.contains("www") ||
          !widget.linkController.text.contains(".") ||
          widget.linkController.text.length < 6;

      phoneError = widget.phoneController.text.isEmpty ||
          widget.phoneController.text.length < 9;
    });

    if (formKey.currentState!.validate()) {
      if (!phoneError && !emailError && !linkError) {
        widget.changePage(2);
      }
    }
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
                            maxHeight:
                                Sizer.calculateVertical(context, 55) >= 36
                                    ? Sizer.calculateVertical(context, 55)
                                    : 36,
                          ),
                          fieldSemantic: "Digite o número do whatsapp",
                          hintSemantic: "Whatsapp",
                          controller: widget.phoneController,
                          inputFormatters: [InputMasksHelper.cellPhone],
                          onError: phoneError,
                          onChanged: (_) => setState(() {
                            phoneError = widget.phoneController.text.isEmpty ||
                                widget.phoneController.text.length < 9;
                          }),
                          hint: "Digite o número do whatsapp",
                          label: "Whatsapp",
                          height: returnHeight(),
                          width: Sizer.calculateHorizontal(context, size.width),
                        ),
                      ),
                      StaticWebFieldWidget(
                        maxLength: 50,
                        constraints: BoxConstraints(
                          minHeight: 35,
                          maxHeight: Sizer.calculateVertical(context, 55) >= 36
                              ? Sizer.calculateVertical(context, 55)
                              : 36,
                        ),
                        fieldSemantic: "Campo de texto do Email.",
                        hintSemantic: "Email",
                        controller: widget.emailController,
                        onError: emailError,
                        onChanged: (_) => setState(() {
                          emailError = widget.emailController.text.isEmpty ||
                              !widget.emailController.text.contains("@") ||
                              !widget.emailController.text.contains(".") ||
                              widget.emailController.text.length < 6;
                        }),
                        hint: "Digite o Email de contato",
                        label: "Email",
                        height: returnHeight(),
                        width: Sizer.calculateHorizontal(context, size.width),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: StaticWebFieldWidget(
                          maxLength: 50,
                          constraints: BoxConstraints(
                            minHeight: 35,
                            maxHeight:
                                Sizer.calculateVertical(context, 55) >= 36
                                    ? Sizer.calculateVertical(context, 55)
                                    : 36,
                          ),
                          fieldSemantic: "Campo de texto do Link.",
                          hintSemantic: "Link",
                          controller: widget.linkController,
                          onError: linkError,
                          onChanged: (_) => setState(() {
                            linkError = widget.linkController.text.isEmpty ||
                                !widget.linkController.text.contains("www") ||
                                !widget.linkController.text.contains(".") ||
                                widget.linkController.text.length < 6;
                          }),
                          hint: "Digite o Link de contato",
                          label: "Link",
                          height: returnHeight(),
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
                      OutlinedButtonWidget(
                        height: Sizer.calculateVertical(context, 55) >= 36
                            ? Sizer.calculateVertical(context, 55)
                            : 36,
                        width: Sizer.calculateHorizontal(context, 30),
                        onPressed: () => widget.changePage(0),
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
      ),
    );
  }
}
