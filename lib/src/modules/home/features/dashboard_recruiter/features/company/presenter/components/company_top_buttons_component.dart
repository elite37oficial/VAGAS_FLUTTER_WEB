import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/domain/usecases/change_image_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/domain/usecases/create_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/infra/datasources/change_image_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/infra/datasources/create_company_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/infra/repositories/change_image_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/infra/repositories/create_company_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/presenter/blocs/blocs/change_image_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/presenter/blocs/blocs/create_company_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/presenter/pages/create_company_page.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class CompanyTopButtonsComponent extends StatelessWidget {
  const CompanyTopButtonsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40, top: 60),
              child: ResponsiveTextWidget(
                text: "Empresas cadastradas",
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w700),
                hintSemantics: "empresas",
                tooltipSemantics: "empresas",
                maxLines: 2,
                maxFontSize: 32,
                minFontSize: 27,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Semantics(
              button: true,
              tooltip: "nova",
              hint: "nova",
              enabled: true,
              child: Tooltip(
                message: "nova",
                child: SizedBox(
                  height: Sizer.calculateVertical(context, 40) <= 20
                      ? 20
                      : Sizer.calculateVertical(context, 40),
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => CreateCompanyBloc(
                                usecase: CreateCompanyUsecase(
                                  repository:
                                      CreateCompanyRepositoryImplementation(
                                    datasource:
                                        CreateCompanyDatasourceImplementation(
                                      requester: AppRequesterImplementation(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            BlocProvider(
                              create: (context) => ChangeImageBloc(
                                usecase: ChangeImageUsecase(
                                  repository:
                                      ChangeImageRepositoryImplementation(
                                    datasource:
                                        ChangeImageDatasourceImplementation(
                                      requester: AppRequesterImplementation(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          child: const CreateCompanyPage(),
                        );
                      },
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.greyBlue,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.add_rounded,
                          color: AppColors.white,
                        ),
                        const Spacer(),
                        ResponsiveTextWidget(
                          text: "Nova",
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                          hintSemantics: "nova",
                          tooltipSemantics: "nova",
                          maxLines: 1,
                          maxFontSize: 12,
                          minFontSize: 8,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
