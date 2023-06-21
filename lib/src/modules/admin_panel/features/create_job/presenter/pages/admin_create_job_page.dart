import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/presenter/blocs/blocs/admin_create_job_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/presenter/blocs/events/admin_create_job_events.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/presenter/blocs/states/admin_create_job_states.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/presenter/components/admin_create_contact_job_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/presenter/components/admin_create_data_job_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/presenter/components/admin_create_description_job_component.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/presenter/components/admin_success_popup_component.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';

class AdminCreatejobPage extends StatefulWidget {
  const AdminCreatejobPage({Key? key}) : super(key: key);

  @override
  State<AdminCreatejobPage> createState() => _AdminCreatejobPageState();
}

class _AdminCreatejobPageState extends State<AdminCreatejobPage> {
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

  late AdminCreateJobBloc createJobBloc;

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

    createJobBloc.add(DoAdminCreateJobEvent(
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
    createJobBloc = BlocProvider.of<AdminCreateJobBloc>(context);
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

    return BlocBuilder<AdminCreateJobBloc, AdminCreateJobStates>(
        bloc: createJobBloc,
        builder: (context, state) {
          if (state is AdminCreateJobSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              _showSuccessAlert("Sua vaga foi publicada com sucesso!");
            });
            createJobBloc
                .add(CleanStateEvent(state: AdminCreateJobInitialState()));
          }

          if (state is AdminCreateJobErrorState) {
            log(state.message);
          }

          return createJobBloc.state is AdminCreateJobLoadingState
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
                          AdminCreateDataJobComponent(
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
                          AdminCreateContactjobComponent(
                            changePage: changePage,
                            phoneController: phoneController,
                            emailController: emailController,
                            linkController: linkController,
                            cityController: cityController,
                            stateController: stateController,
                          ),
                          AdminCreateDescriptionjobComponent(
                            changePage: changePage,
                            createJob: createJob,
                            descriptionController: descriptionController,
                          ),
                          const AdminSuccessPopupComponent(),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}
