import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/pages/create_contact_job_page.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/pages/create_data_job_page.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/pages/create_description_job_page.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class CreatejobPage extends StatefulWidget {
  const CreatejobPage({Key? key}) : super(key: key);

  @override
  State<CreatejobPage> createState() => _CreatejobPageState();
}

class _CreatejobPageState extends State<CreatejobPage> {
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
              CreateDataJobPage(changePage: changePage),
              CreateContactjobPage(changePage: changePage),
              CreateDescriptionjobPage(changePage: changePage)
            ],
          ),
        ),
      ),
    );
  }
}
