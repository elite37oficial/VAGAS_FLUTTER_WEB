import 'package:estados_municipios/estados_municipios.dart';
import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/helpers/masks/input_masks_helper.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class EditContactjobComponent extends StatefulWidget {
  final Function changePage;
  final TextEditingController phoneController;
  final TextEditingController linkController;
  final TextEditingController emailController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  const EditContactjobComponent({
    Key? key,
    required this.changePage,
    required this.emailController,
    required this.linkController,
    required this.phoneController,
    required this.stateController,
    required this.cityController,
  }) : super(key: key);

  @override
  State<EditContactjobComponent> createState() =>
      _EditContactjobComponentState();
}

class _EditContactjobComponentState extends State<EditContactjobComponent> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool phoneError = false;
  bool linkError = false;
  bool emailError = false;

  bool cityError = false;
  bool stateError = false;

  List<DropdownMenuItem<String>> _estadoItens = [];
  List<DropdownMenuItem<String>> _municipioItens = [];

  String _estadoSelecionado = "";
  String _municipioSelecionado = "";

  EstadosMunicipiosController stateCityController =
      EstadosMunicipiosController();

  Future<void> _loadEstados() async {
    List<Estado> estados = await stateCityController.buscaTodosEstados();
    setState(() {
      _estadoItens = estados
          .map((estado) =>
              DropdownMenuItem(value: estado.sigla, child: Text(estado.sigla!)))
          .toList();
    });
  }

  Future<void> _loadMunicipios(String estado) async {
    List<Municipio> municipios =
        await stateCityController.buscaMunicipiosPorEstado(estado);

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
      widget.stateController.text = newValue ?? "";
    });
  }

  void _onMunicipioChange(String? newValue) {
    setState(() {
      _municipioSelecionado = newValue ?? "";
      widget.cityController.text = newValue ?? "";
    });
  }

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

      stateError = widget.stateController.text.isEmpty;
      cityError = widget.cityController.text.isEmpty;
    });

    if (formKey.currentState!.validate()) {
      if (!phoneError &&
          !emailError &&
          !linkError &&
          !stateError &&
          !cityError) {
        widget.changePage(2);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadEstados();
    widget.stateController.text.isNotEmpty
        ? _loadMunicipios(widget.stateController.text)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double returnHeight() {
      if (Sizer.calculateVertical(context, 60) > 45) {
        return Sizer.calculateVertical(context, 60);
      } else {
        return 45;
      }
    }

    double returnMaxHeight() {
      if (Sizer.calculateVertical(context, 100) <= 50 &&
          Sizer.calculateVertical(context, 100) > 45) {
        return Sizer.calculateVertical(context, 100);
      } else if (Sizer.calculateVertical(context, 100) >= 50) {
        return 50;
      } else {
        return 46;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.white,
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
                              text:
                                  "2 de 3: Formas do canditato entrar em contato",
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                              maxLines: 2,
                              maxFontSize: 30,
                              minFontSize: 22,
                              textAlign: TextAlign.left,
                              hintSemantics:
                                  "2 de 3: Formas do canditato entrar em contato",
                              tooltipSemantics:
                                  "2 de 3: Formas do canditato entrar \nem contato",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.66,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: StaticWebFieldWidget(
                          constraints: BoxConstraints(
                            minHeight: 35,
                            maxHeight: returnMaxHeight(),
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
                          maxHeight: returnMaxHeight(),
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
                            maxHeight: returnMaxHeight(),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          width: size.width * 0.8,
                          height: 80,
                          child: AppMenuDropDownWidget(
                            height: returnMaxHeight(),
                            semantics: "Selecione um estado",
                            controller: widget.stateController,
                            hint: "Selecione um estado",
                            label: "Estado",
                            listItens: _estadoItens,
                            onChanged: _onEstadoChange,
                            error: stateError,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.8,
                        height: 80,
                        child: AppMenuDropDownWidget(
                          height: returnMaxHeight(),
                          semantics: "Selecione uma cidade",
                          controller: widget.cityController,
                          hint: "Selecione uma cidade",
                          label: "Cidade",
                          listItens: _municipioItens,
                          onChanged: _onMunicipioChange,
                          error: cityError,
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
