import 'dart:convert';
import 'dart:developer';

import 'package:estados_municipios/estados_municipios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/usecases/admin_create_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/datasources/admin_create_company_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/repositories/admin_create_company_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/presenter/blocs/blocs/admin_change_image_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/presenter/blocs/blocs/admin_create_company_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/presenter/blocs/events/admin_change_image_event.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/presenter/blocs/events/admin_create_company_event.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/presenter/blocs/states/admin_create_company_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/messages_helper.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class CreateCompanyPage extends StatefulWidget {
  const CreateCompanyPage({Key? key}) : super(key: key);

  @override
  State<CreateCompanyPage> createState() => _CreateCompanyPageState();
}

class _CreateCompanyPageState extends State<CreateCompanyPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int page = 0;

  final ImagePicker picker = ImagePicker();
  String? imageName;
  String? imageType;
  String? imageBase64;

  bool imageError = false;
  bool nameError = false;
  bool stateError = false;
  bool cityError = false;
  bool descriptionError = false;

  TextEditingController nameController = TextEditingController();
  EstadosMunicipiosController stateController = EstadosMunicipiosController();
  TextEditingController stateTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> _getImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (image.mimeType == "image/jpeg" || image.mimeType == "image/png") {
        if ((image.path.length / 1024) / 1024 <= 12) {
          setState(() => imageName = image.name);
          final List<int> imageBytes = await image.readAsBytes();
          imageType = image.mimeType;
          imageBase64 = base64.encode(imageBytes);
        }
      }
    }
  }

  List<DropdownMenuItem<String>> _estadoItens = [];
  List<DropdownMenuItem<String>> _municipioItens = [];

  String _estadoSelecionado = "";
  String _municipioSelecionado = "";

  @override
  void initState() {
    super.initState();
    _loadEstados();
  }

  Future<void> _loadEstados() async {
    List<Estado> estados = await stateController.buscaTodosEstados();
    setState(() {
      _estadoItens = estados
          .map((estado) =>
              DropdownMenuItem(value: estado.sigla, child: Text(estado.sigla!)))
          .toList();
    });
  }

  Future<void> _loadMunicipios(String estado) async {
    List<Municipio> municipios =
        await stateController.buscaMunicipiosPorEstado(estado);
    setState(() {
      _municipioItens = municipios
          .map((municipio) => DropdownMenuItem(
              value: municipio.nome, child: Text(municipio.nome!)))
          .toList();
    });
  }

  void _onEstadoChange(String? newValue) {
    setState(() {
      _estadoSelecionado = newValue ?? "";
      _municipioSelecionado = "";
      _loadMunicipios(_estadoSelecionado);
      stateTextController.text = newValue ?? "";
    });
  }

  void _onMunicipioChange(String? newValue) {
    setState(() {
      _municipioSelecionado = newValue ?? "";
      cityTextController.text = newValue ?? "";
    });
  }

  _validateForm(GlobalKey<FormState> formKey) async {
    setState(() {
      nameError = nameController.text.isEmpty || nameController.text.length < 4;
      stateError = stateTextController.text.isEmpty;
      cityError = cityTextController.text.isEmpty;
      descriptionError = descriptionController.text.isEmpty ||
          descriptionController.text.length < 6;
      imageError = imageBase64.toString().isEmpty;
    });

    if (formKey.currentState!.validate()) {
      final stateTextControllerText = stateTextController.text;
      final cityTextControllerText = cityTextController.text;
      if (!nameError &&
          !stateError &&
          !cityError &&
          !descriptionError &&
          !imageError) {
        context.read<AdminCreateCompanyBloc>().add(DoAdminCreateCompanyEvent(
              name: nameController.text,
              location: "$stateTextControllerText - $cityTextControllerText",
              description: descriptionController.text,
            ));
        await for (final state
            in context.read<AdminCreateCompanyBloc>().stream) {
          if (state is AdminCreateCompanySuccessState) {
            final companyId = state.company.id;
            context.read<AdminChangeImageBloc>().add(DoAdminChangeImageEvent(
                  companyId: companyId,
                  image64: "data:$imageType;base64,$imageBase64",
                ));
            break;
          }
        }
        return WidgetsBinding.instance.addPostFrameCallback((_) async {
          _showSuccessAlert(MessagesHelper.successRegisterMessage);
        });
      }
    }
  }

  _showErrorAlert(String message) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) {
        return ErrorPopUpWidget.show(
          context: context,
          height: Sizer.calculateVertical(context, 350) >= 320
              ? Sizer.calculateVertical(context, 350)
              : 320,
          width: Sizer.calculateHorizontal(context, 170) >= 370
              ? Sizer.calculateHorizontal(context, 170)
              : 370,
          message: message,
          function: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  _showSuccessAlert(String message) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) {
        return SuccessPopUpWidget.show(
          context: context,
          height: Sizer.calculateVertical(context, 350) >= 320
              ? Sizer.calculateVertical(context, 350)
              : 320,
          width: Sizer.calculateHorizontal(context, 170) >= 370
              ? Sizer.calculateHorizontal(context, 170)
              : 370,
          message: message,
          function: () {
            context.pop();
            context.pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final AdminCreateCompanyBloc createCompanyBloc = AdminCreateCompanyBloc(
      usecase: AdminCreateCompanyUsecase(
        repository: AdminCreateCompanyRepositoryImplementation(
          datasource: AdminCreateCompanyDatasourceImplementation(
            requester: AppRequesterImplementation(),
          ),
        ),
      ),
    );

    return BlocBuilder<AdminCreateCompanyBloc, AdminCreateCompanyStates>(
      bloc: createCompanyBloc,
      builder: (context, state) {
        if (state is AdminCreateCompanyLoadingState) {
          return const LoadingPage();
        }
        if (state is AdminCreateCompanySuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            _showSuccessAlert(MessagesHelper.successRegisterMessage);
          });
        }
        if (state is AdminCreateCompanyErrorState) {
          log(state.message);
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            _showErrorAlert(state.message);
          });
        }

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.zero,
          content: StatefulBuilder(builder: (context, state) {
            return SizedBox(
              height: 550,
              width: 550,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width * 0.5),
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width * 0.35,
                                height:
                                    Sizer.calculateVertical(context, 95) <= 35
                                        ? 35
                                        : Sizer.calculateVertical(context, 95),
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
                                    maxLines: 2,
                                    hintSemantics: "cadastre",
                                    tooltipSemantics: "cadastre",
                                    minFontSize: 24,
                                  ),
                                ),
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
                          const SizedBox(height: 20),
                          SizedBox(
                            width: size.width * 0.8,
                            height: Sizer.calculateVertical(context, 40) <= 35
                                ? 35
                                : Sizer.calculateVertical(context, 40),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ResponsiveTextWidget(
                                text: "Imagem",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: StaticWebFieldWidget(
                              maxLength: 50,
                              constraints: const BoxConstraints(
                                minHeight: 35,
                                maxHeight: 55,
                              ),
                              fieldSemantic: "Campo de texto do nome.",
                              hintSemantic: "nome",
                              controller: nameController,
                              onError: nameError,
                              onChanged: (_) => setState(() {
                                nameError = nameController.text.isEmpty ||
                                    nameController.text.length < 4;
                              }),
                              hint: "Nome da empresa",
                              label: "Nome",
                              width: Sizer.calculateHorizontal(
                                  context, size.width),
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: size.width * 0.8,
                            height: 80,
                            child: AppMenuDropDownWidget(
                              height: Sizer.calculateVertical(context, 50) >= 45
                                  ? Sizer.calculateVertical(context, 50)
                                  : 45,
                              semantics: "Selecione um estado",
                              controller: stateTextController,
                              hint: "Selecione um estado",
                              label: "Estado",
                              listItens: _estadoItens,
                              onChanged: _onEstadoChange,
                              error: stateError,
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: size.width * 0.8,
                            height: 80,
                            child: AppMenuDropDownWidget(
                              height: Sizer.calculateVertical(context, 50) >= 45
                                  ? Sizer.calculateVertical(context, 50)
                                  : 45,
                              semantics: "Selecione um municipio",
                              controller: cityTextController,
                              hint: "Selecione um municipio",
                              label: "Municipio",
                              listItens: _municipioItens,
                              onChanged: _onMunicipioChange,
                              error: cityError,
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: size.width * 0.8,
                            height: Sizer.calculateVertical(context, 40) <= 35
                                ? 35
                                : Sizer.calculateVertical(context, 40),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ResponsiveTextWidget(
                                text: "Sobre*",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
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
                            width: size.width * 0.8,
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
                            child: TextField(
                              controller: descriptionController,
                              decoration: const InputDecoration(
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
                                height:
                                    Sizer.calculateVertical(context, 55) <= 20
                                        ? 20
                                        : Sizer.calculateVertical(context, 55),
                                width: 160,
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
                                height:
                                    Sizer.calculateVertical(context, 55) <= 20
                                        ? 20
                                        : Sizer.calculateVertical(context, 55),
                                width: 160,
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
              ),
            );
          }),
        );
      },
    );
  }
}
