import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/presenter/blocs/blocs/edit_job_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/presenter/blocs/blocs/get_job_by_id_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/presenter/components/edit_contact_job_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/presenter/components/edit_data_job_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/presenter/components/edit_description_job_component.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/presenter/blocs/blocs/get_job_bloc.dart'
    as listJob;
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';

class EditjobPage extends StatefulWidget {
  final String jobId;
  const EditjobPage({Key? key, required this.jobId}) : super(key: key);

  @override
  State<EditjobPage> createState() => _EditjobPageState();
}

class _EditjobPageState extends State<EditjobPage> {
  int page = 0;

  TextEditingController idController = TextEditingController();
  TextEditingController statusController = TextEditingController();
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

  late EditJobBloc editJobBloc;
  late GetJobByIdBloc getJobBloc;

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

  editJob() async {
    String userId =
        await SecureStorageManager.readData(StorageKeys.userId) ?? "";
    double salary = double.parse(salaryController.text
        .replaceAll("R\$", "")
        .replaceAll(" ", "")
        .replaceAll(".", "")
        .replaceAll(",", "."));

    editJobBloc.add(DoEditJobEvent(
      id: idController.text,
      status: statusController.text,
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

  getJobById(JobEntity job) async {
    setState(() {
      idController.text = job.id;
      statusController.text = job.status;
      titleController.text = job.title;
      descriptionController.text = job.description;
      companyDescriptionController.text = job.companyDescription;
      companyIdController.text = job.companyId;
      localController.text = job.modality;
      typeJobController.text = job.regime;
      linkController.text = job.link;
      emailController.text = job.email;
      phoneController.text = job.whatsapp;
      levelController.text = job.seniority;
      salaryController.text = job.salary.toString();
      stateController.text = job.state;
      cityController.text = job.city;
    });
  }

  @override
  void initState() {
    editJobBloc = BlocProvider.of<EditJobBloc>(context);
    getJobBloc = BlocProvider.of<GetJobByIdBloc>(context);
    getJobBloc.add(DoGetJobByIdEvent(jobId: widget.jobId));

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

    return BlocBuilder<EditJobBloc, EditJobStates>(
        bloc: editJobBloc,
        builder: (context, state) {
          if (state is EditJobSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              _showSuccessAlert("Sua vaga foi editada com sucesso!");
            });
            editJobBloc.add(CleanStateEvent(state: EditJobInitialState()));
          }

          if (state is EditJobErrorState) {
            log(state.message);
          }

          return MultiBlocListener(
            listeners: [
              BlocListener<EditJobBloc, EditJobStates>(
                listener: (context, state) {
                  if (state is EditJobSuccessState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      _showSuccessAlert("Sua vaga foi editada com sucesso!");
                    });
                    context
                        .read<listJob.GetJobBloc>()
                        .add(const listJob.GetJobListEvent(page: 1));
                    editJobBloc
                        .add(CleanStateEvent(state: EditJobInitialState()));
                  }

                  if (state is EditJobErrorState) {
                    log(state.message);
                  }
                },
              ),
              BlocListener<GetJobByIdBloc, GetJobByIdStates>(
                listener: (context, state) {
                  if (state is GetJobByIdSuccessState) {
                    JobEntity job = state.response;
                    getJobById(job);
                    getJobBloc.add(
                        CleanGetJobByIdStateEvent(state: GetJobByIdInitialState()));
                  }
                  if (state is GetJobByIdErrorState) {
                    log(state.message);
                  }
                },
              ),
            ],
            child: editJobBloc.state is EditJobLoadingState ||
                    getJobBloc.state is GetJobByIdLoadingState
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
                            EditDataJobComponent(
                              companyInitial: companyIdController.text,
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
                            EditContactjobComponent(
                              changePage: changePage,
                              phoneController: phoneController,
                              emailController: emailController,
                              linkController: linkController,
                              cityController: cityController,
                              stateController: stateController,
                            ),
                            EditDescriptionjobComponent(
                              changePage: changePage,
                              editJob: editJob,
                              descriptionController: descriptionController,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        });
  }
}
