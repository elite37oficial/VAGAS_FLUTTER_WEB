import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/blocs/blocs/create_job_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/components/create_contact_job_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/components/create_data_job_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/components/create_description_job_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/components/success_popup_component.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';

class CreatejobPage extends StatefulWidget {
  const CreatejobPage({Key? key}) : super(key: key);

  @override
  State<CreatejobPage> createState() => _CreatejobPageState();
}

class _CreatejobPageState extends State<CreatejobPage> {
  int page = 0;

  TextEditingController companyController = TextEditingController();
  TextEditingController companyDescriptionController = TextEditingController();
  TextEditingController companyIdController = TextEditingController();
  TextEditingController localController = TextEditingController();
  TextEditingController typeJobController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  TextEditingController salaryController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  late CreateJobBloc createJobBloc;

  _showSuccessAlert(String message) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) {
        return SuccessPopUpWidget.show(
          context: context,
          height: Sizer.calculateVertical(context, 250),
          width: Sizer.calculateHorizontal(context, 350) <= 600
              ? Sizer.calculateHorizontal(context, 350)
              : 600,
          message: message,
          function: () {
            context.pop();
            context.pop();
          },
        );
      },
    );
  }

  createJob() async {
    String userId =
        await SecureStorageManager.readData(StorageKeys.userId) ?? "";
    double salary = double.parse(salaryController.text
        .replaceAll("R\$", "")
        .replaceAll(" ", "")
        .replaceAll(".", "")
        .replaceAll(",", "."));

    createJobBloc.add(DoCreateJobEvent(
      title: titleController.text,
      description: descriptionController.text,
      companyDescription: companyDescriptionController.text,
      companyId: companyIdController.text,
      userId: userId,
      type: typeJobController.text,
      level: levelController.text,
      phone: phoneController.text,
      email: emailController.text,
      modality: localController.text,
      link: linkController.text,
      salary: salary,
      state: stateController.text,
      city: cityController.text,
    ));
  }

  @override
  void initState() {
    createJobBloc = BlocProvider.of<CreateJobBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    PageController pageController = PageController();

    void changePage(value) {
      page = value;
      pageController.animateToPage(
        value,
        duration: const Duration(milliseconds: 10),
        curve: Curves.decelerate,
      );
      setState(() {});
    }

    return BlocBuilder<CreateJobBloc, CreateJobStates>(
        bloc: createJobBloc,
        builder: (context, state) {
          if (state is CreateJobSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              _showSuccessAlert("Sua vaga foi publicada com sucesso!");
            });
            createJobBloc.add(CleanStateEvent(state: CreateJobInitialState()));
          }

          if (state is CreateJobErrorState) {
            log(state.message);
          }

          return createJobBloc.state is CreateJobLoadingState
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.greyBlue,
                  ),
                )
              : Scaffold(
                  backgroundColor: AppColors.transparent,
                  body: SizedBox(
                    height: page == 3
                        ? Sizer.calculateVertical(context, 300)
                        : null,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: PageView(
                        controller: pageController,
                        pageSnapping: false,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (value) {},
                        children: [
                          CreateDataJobComponent(
                            changePage: changePage,
                            companyController: companyController,
                            companyIdController: companyIdController,
                            companyDescriptionController:
                                companyDescriptionController,
                            levelController: levelController,
                            localController: localController,
                            titleController: titleController,
                            typeJobController: typeJobController,
                            salaryController: salaryController,
                          ),
                          CreateContactjobComponent(
                            changePage: changePage,
                            phoneController: phoneController,
                            emailController: emailController,
                            linkController: linkController,
                            cityController: cityController,
                            stateController: stateController,
                          ),
                          CreateDescriptionjobComponent(
                            changePage: changePage,
                            createJob: createJob,
                            descriptionController: descriptionController,
                          ),
                          const SuccessPopupComponent(),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}
