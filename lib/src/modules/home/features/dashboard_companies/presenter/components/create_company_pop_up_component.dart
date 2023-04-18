import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class CreateCompanyPopUp extends StatefulWidget {
  const CreateCompanyPopUp({Key? key}) : super(key: key);

  @override
  _CreateCompanyPopUpState createState() => _CreateCompanyPopUpState();
}

class _CreateCompanyPopUpState extends State<CreateCompanyPopUp> {
  final ImagePicker picker = ImagePicker();
  String? imageName;
  String? imageBase64;

  Future<void> getImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (image.mimeType == "image/jpeg" || image.mimeType == "image/png") {
        if ((image.path.length / 1024) / 1024 <= 12) {
          setState(() => imageName = image.name);
          final List<int> imageBytes = await image.readAsBytes();
          imageBase64 = base64.encode(imageBytes);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: size.width * 0.5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.3,
                    height: Sizer.calculateVertical(context, 40) <= 35
                        ? 35
                        : Sizer.calculateVertical(context, 40),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ResponsiveTextWidget(
                        text: "Cadastre sua empresa",
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.black,
                                ),
                        maxLines: 1,
                        hintSemantics: "cadastre",
                        tooltipSemantics: "cadastre",
                        minFontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Sizer.calculateVertical(context, 35) <= 35
                        ? 35
                        : Sizer.calculateVertical(context, 35),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.close),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: size.width * 0.7,
                height: Sizer.calculateVertical(context, 40) <= 35
                    ? 35
                    : Sizer.calculateVertical(context, 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ResponsiveTextWidget(
                    text: "Imagem",
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                    maxLines: 1,
                    hintSemantics: "imagem",
                    tooltipSemantics: "imagem",
                    minFontSize: 8,
                    maxFontSize: 14,
                  ),
                ),
              ),
              Container(
                width: size.width,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: getImage,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.grey),
                      child: const Text(
                        'Selecionar imagem',
                        style: TextStyle(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Escolha a imagem da sua empresa',
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: size.width * 0.7,
                height: Sizer.calculateVertical(context, 40) <= 35
                    ? 35
                    : Sizer.calculateVertical(context, 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ResponsiveTextWidget(
                    text: "Nome",
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                    maxLines: 1,
                    hintSemantics: "nome",
                    tooltipSemantics: "nome",
                    minFontSize: 8,
                    maxFontSize: 14,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nome da empresa',
                  ),
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: size.width * 0.7,
                height: Sizer.calculateVertical(context, 40) <= 35
                    ? 35
                    : Sizer.calculateVertical(context, 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ResponsiveTextWidget(
                    text: "Sobre*",
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                    maxLines: 1,
                    hintSemantics: "sobre",
                    tooltipSemantics: "sobre",
                    minFontSize: 16,
                    maxFontSize: 24,
                  ),
                ),
              ),
              Container(
                width: size.width * 0.7,
                height: Sizer.calculateVertical(context, 200) <= 35
                    ? 35
                    : Sizer.calculateVertical(context, 200),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Escreva sobre a empresa',
                  ),
                  maxLines: 10,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: SizedBox(
                  width: size.width * 0.5,
                  child: const Divider(
                    thickness: 1.5,
                    color: AppColors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButtonWidget(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    height: Sizer.calculateVertical(context, 55) <= 20
                        ? 20
                        : Sizer.calculateVertical(context, 55),
                    width: size.width * 0.12,
                    tooltip: "cancelar",
                    hintSemantics: "cancelar",
                    child: ResponsiveTextWidget(
                      text: "Cancelar",
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.greyBlue,
                              ),
                      hintSemantics: "cancelar",
                      tooltipSemantics: "cancelar",
                      maxLines: 1,
                      minFontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 10),
                  FilledButtonWidget(
                    onPressed: () {},
                    height: Sizer.calculateVertical(context, 55) <= 20
                        ? 20
                        : Sizer.calculateVertical(context, 55),
                    width: size.width * 0.12,
                    tooltip: "salvar",
                    hintSemantics: "salvar",
                    child: ResponsiveTextWidget(
                      text: "Salvar alterações",
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.white,
                              ),
                      hintSemantics: "salvar",
                      tooltipSemantics: "salvar",
                      maxLines: 1,
                      minFontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
