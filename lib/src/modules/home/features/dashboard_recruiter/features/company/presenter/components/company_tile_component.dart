import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/usecases/edit_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/usecases/edit_image_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/usecases/get_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/datasources/edit_company_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/datasources/edit_image_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/datasources/get_company_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/repositories/edit_company_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/repositories/edit_image_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/repositories/get_company_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/presenter/blocs/bloc/edit_company_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/presenter/blocs/bloc/edit_image_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/presenter/blocs/bloc/get_company_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/presenter/pages/edit_company_page.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class CompanyTileComponent extends StatelessWidget {
  final int index;
  final CompanyEntity companyTileData;
  const CompanyTileComponent(
      {Key? key, required this.index, required this.companyTileData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: Sizer.calculateVertical(context, 55) <= 40
          ? 40
          : Sizer.calculateVertical(context, 55),
      color: index % 2 == 0 ? AppColors.accentWhite : AppColors.white,
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: SizedBox(
              width: size.width * 0.7,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: Sizer.calculateVertical(context, 5) > 35
                          ? 35
                          : Sizer.calculateVertical(context, 5),
                      bottom: Sizer.calculateVertical(context, 5) > 35
                          ? 35
                          : Sizer.calculateVertical(context, 5),
                      left: Sizer.calculateHorizontal(context, 10) > 35
                          ? 35
                          : Sizer.calculateHorizontal(context, 10),
                      right: Sizer.calculateHorizontal(context, 10) > 25
                          ? 25
                          : Sizer.calculateHorizontal(context, 10),
                    ),
                    child: FadeInImage.assetNetwork(
                      placeholder: "",
                      placeholderErrorBuilder: (context, error, stackTrace) =>
                          Container(),
                      image: Endpoints.getCompanyImageById(companyTileData.id),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Container();
                      },
                    ),
                  ),
                  Expanded(
                    child: ResponsiveTextWidget(
                      text: companyTileData.name,
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      hintSemantics: "nome",
                      tooltipSemantics: "nome",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: SizedBox(
              width: size.width * 0.7,
              child: ResponsiveTextWidget(
                text: companyTileData.description,
                textStyle: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                hintSemantics: "descrição",
                tooltipSemantics: "descrição",
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: SizedBox(
              width: size.width * 0.7,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider<EditCompanyBloc>(
                              create: (context) => EditCompanyBloc(
                                usecase: EditCompanyUsecase(
                                  repository:
                                      EditCompanyRepositoryImplementation(
                                    datasource:
                                        EditCompanyDatasourceImplementation(
                                      requester: AppRequesterImplementation(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            BlocProvider<EditImageBloc>(
                              create: (context) => EditImageBloc(
                                usecase: EditImageUsecase(
                                  repository: EditImageRepositoryImplementation(
                                    datasource:
                                        EditImageDatasourceImplementation(
                                      requester: AppRequesterImplementation(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            BlocProvider<GetCompanyBloc>(
                              create: (context) => GetCompanyBloc(
                                usecase: GetCompanyUsecase(
                                  repository:
                                      GetCompanyRepositoryImplementation(
                                    datasource:
                                        GetCompanyDatasourceImplementation(
                                      requester: AppRequesterImplementation(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          child: EditCompanyPage(
                            id: companyTileData.id,
                          ),
                        );
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    AppImages.editIcon,
                    package: "vagas_design_system",
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
