import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/domain/entities/create_company_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/bloc/bloc/create_company_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/bloc/events/create_company_event.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/bloc/states/create_company_states.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class CreateCompanyPopUp extends StatefulWidget {
  const CreateCompanyPopUp({Key? key}) : super(key: key);

  @override
  State<CreateCompanyPopUp> createState() => _CreateCompanyPopUpState();
}

class _CreateCompanyPopUpState extends State<CreateCompanyPopUp> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ImagePicker picker = ImagePicker();
  String? imageName;
  String? imageBase64;

  bool nameError = false;
  bool descriptionError = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> _getImage() async {
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

  _validateForm(GlobalKey<FormState> formKey) {
    setState(() {
      nameError = nameController.text.isEmpty;

      descriptionError = descriptionController.text.isEmpty;
    });

    if (formKey.currentState!.validate()) {
      if (!nameError && !descriptionError) {
        context.read<CreateCompanyBloc>().add(
              DoCreateCompanyEvent(
                createCompanyData: CreateCompanyEntity(
                  name: nameController.text,
                  description: descriptionController.text,
                  location: "",
                  status: "",
                ),
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<CreateCompanyBloc, CreateCompanyStates>(
      builder: (context, state) {
        if (state is CreateCompanyLoadingState) {
          return const LoadingPage();
        }
        if (state is CreateCompanyErrorState) {
          log(state.message);
        }
        if (state is CreateCompanySuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            context.pop();
          });
        }
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width * 0.5),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
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
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
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
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                            onPressed: _getImage,
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
                          Expanded(
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: imageName ??
                                    'Escolha a imagem da sua empresa',
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
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
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
                          onPressed: () => _validateForm(formKey),
                          height: Sizer.calculateVertical(context, 55) <= 20
                              ? 20
                              : Sizer.calculateVertical(context, 55),
                          width: size.width * 0.12,
                          tooltip: "salvar",
                          hintSemantics: "salvar",
                          child: ResponsiveTextWidget(
                            text: "Salvar alterações",
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
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
          ),
        );
      },
    );
  }
}
