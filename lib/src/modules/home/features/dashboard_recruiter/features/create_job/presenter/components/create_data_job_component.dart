import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/blocs/blocs/get_all_companies_bloc.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class CreateDataJobComponent extends StatefulWidget {
  final Function changePage;
  final TextEditingController companyController;
  final TextEditingController companyDescriptionController;
  final TextEditingController companyIdController;
  final TextEditingController localController;
  final TextEditingController typeJobController;
  final TextEditingController levelController;
  final TextEditingController titleController;
  final TextEditingController salaryController;
  const CreateDataJobComponent({
    Key? key,
    required this.changePage,
    required this.companyController,
    required this.companyIdController,
    required this.companyDescriptionController,
    required this.levelController,
    required this.localController,
    required this.typeJobController,
    required this.titleController,
    required this.salaryController,
  }) : super(key: key);

  @override
  State<CreateDataJobComponent> createState() => _CreateDataJobComponentState();
}

class _CreateDataJobComponentState extends State<CreateDataJobComponent> {
  GlobalKey<FormState> formKey = GlobalKey();

  late GetAllCompaniesBloc getAllCompaniesBloc;

  bool titleError = false;
  bool levelError = false;
  bool localError = false;
  bool typeJobError = false;
  bool companyError = false;
  bool salaryError = false;

  List<DropdownMenuItem<String>> typeJob = [];
  List<DropdownMenuItem<String>> listCompanies = [];
  List<CompanyEntity> listCompaniesEntities = [];

  _getcompanys() async {
    getAllCompaniesBloc.add(DoGetAllCompaniesEvent());
  }

  _validateForm(formKey) {
    setState(() {
      localError = widget.localController.text.isEmpty;
      companyError = widget.companyController.text.isEmpty;

      typeJobError = widget.typeJobController.text.isEmpty;

      levelError = widget.levelController.text.isEmpty;
      titleError = widget.titleController.text.isEmpty ||
          widget.titleController.text.length < 5;
      salaryError = widget.salaryController.text.isEmpty ||
          widget.salaryController.text.length < 4;
    });

    if (formKey.currentState!.validate()) {
      if (!localError &&
          !titleError &&
          !levelError &&
          !typeJobError &&
          !companyError &&
          !salaryError &&
          !localError) {
        widget.changePage(1);
      }
    }
  }

  @override
  void initState() {
    getAllCompaniesBloc = BlocProvider.of<GetAllCompaniesBloc>(context);
    _getcompanys();
    super.initState();
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

    return BlocBuilder<GetAllCompaniesBloc, GetAllCompaniesStates>(
        builder: (context, state) {
      if (state is GetAllCompaniesSuccessState) {
        listCompaniesEntities = state.listCompanies;
        listCompanies = state.listCompanies
            .map(
              (e) => DropdownMenuItem(
                value: e.name,
                child: ResponsiveTextWidget(text: e.name),
              ),
            )
            .toList();
      }
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
                              width: Sizer.calculateHorizontal(context, 72),
                              child: ResponsiveTextWidget(
                                text: "Contrate \ndesenvolvedores  Flutter.",
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
                                    "Contrate desenvolvedores Flutter.",
                                tooltipSemantics:
                                    "Contrate desenvolvedores Flutter.",
                              ),
                            ),
                          ],
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
                            maxHeight: returnMaxHeight(),
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
                        height: returnMaxHeight(),
                        listItens: listCompanies,
                        error: companyError,
                        onChanged: (value) {
                          for (CompanyEntity company in listCompaniesEntities) {
                            if (company.name == value) {
                              widget.companyDescriptionController.text =
                                  company.description;
                              widget.companyIdController.text = company.id;
                            }
                          }
                          setState(() {
                            widget.companyController.text = value ?? "";

                            companyError =
                                widget.companyController.text.isEmpty;
                          });
                        },
                        label: "Empresa",
                        controller: widget.companyController,
                        hint:
                            "Selecione a empresa para qual você está contratando",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: AppMenuDropDownWidget(
                          semantics: "Nível",
                          height: returnMaxHeight(),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: StaticWebFieldWidget(
                          maxLength: 50,
                          constraints: BoxConstraints(
                            minHeight: 35,
                            maxHeight: returnMaxHeight(),
                          ),
                          fieldSemantic: "Campo de texto do Salário.",
                          hintSemantic: "Salário",
                          controller: widget.salaryController,
                          onError: salaryError,
                          inputFormatters: [
                            CurrencyTextInputFormatter(
                              decimalDigits: 2,
                              locale: 'pt_br',
                              symbol: "R\$",
                            )
                          ],
                          onChanged: (value) {
                            setState(() {
                              titleError =
                                  widget.salaryController.text.isEmpty ||
                                      widget.salaryController.text.length < 4;
                            });
                          },
                          hint: "Salário para qual você está contratando",
                          label: "Salário",
                          height: returnHeight(),
                          width: Sizer.calculateHorizontal(context, size.width),
                        ),
                      ),
                      AppMenuDropDownWidget(
                        semantics: "local de trabalho",
                        height: returnMaxHeight(),
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
                        padding: const EdgeInsets.only(top: 15),
                        child: AppMenuDropDownWidget(
                          semantics: "tipo de vaga",
                          height: returnMaxHeight(),
                          listItens: [
                            DropdownMenuItem(
                              value: "Tempo Integral",
                              child:
                                  ResponsiveTextWidget(text: "Tempo Integral"),
                            ),
                            DropdownMenuItem(
                              value: "Tempo Parcial",
                              child:
                                  ResponsiveTextWidget(text: "Tempo Parcial"),
                            ),
                            DropdownMenuItem(
                              value: "Outro",
                              child: ResponsiveTextWidget(text: "Outro"),
                            ),
                          ],
                          error: typeJobError,
                          onChanged: (value) => setState(() {
                            widget.typeJobController.text = value ?? "";

                            typeJobError =
                                widget.typeJobController.text.isEmpty;
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
                      height: returnMaxHeight(),
                      width: Sizer.calculateHorizontal(context, 500),
                      onPressed: () => _validateForm(formKey),
                      tooltip: "Continuar",
                      hintSemantics: "Continuar",
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
    });
  }
}
