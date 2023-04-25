import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/pages/create_contact_job_page.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/pages/create_data_job_page.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/pages/create_description_job_page.dart';

class CreatejobPage extends StatefulWidget {
  const CreatejobPage({Key? key}) : super(key: key);

  @override
  State<CreatejobPage> createState() => _CreatejobPageState();
}

class _CreatejobPageState extends State<CreatejobPage> {
  TextEditingController enterpriseController = TextEditingController();
  TextEditingController localController = TextEditingController();
  TextEditingController typeJobController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    PageController pageController = PageController();

    void changePage(value) {
      pageController.animateToPage(
        value,
        duration: const Duration(milliseconds: 10),
        curve: Curves.decelerate,
      );
      setState(() {});
    }

    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: PageView(
            controller: pageController,
            pageSnapping: false,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) {},
            children: [
              CreateDataJobPage(
                changePage: changePage,
                enterpriseController: enterpriseController,
                levelController: levelController,
                localController: localController,
                titleController: titleController,
                typeJobController: typeJobController,
              ),
              CreateContactjobPage(
                changePage: changePage,
                phoneController: phoneController,
                emailController: emailController,
                linkController: linkController,
              ),
              CreateDescriptionjobPage(
                changePage: changePage,
                descriptionController: descriptionController,
              )
            ],
          ),
        ),
      ),
    );
  }
}
