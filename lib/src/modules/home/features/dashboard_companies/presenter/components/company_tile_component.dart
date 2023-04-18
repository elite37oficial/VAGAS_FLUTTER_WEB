import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/components/company_status_component.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
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
            flex: 12,
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        companyTileData.image64,
                      ),
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
            flex: 10,
            child: SizedBox(
              width: size.width * 0.7,
              child: Center(
                child: Align(
                  alignment: Alignment.center,
                  child: CompanyStatusComponent(status: companyTileData.status),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 10,
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
            flex: 10,
            child: SizedBox(
              width: size.width * 0.7,
              child: ResponsiveTextWidget(
                text: companyTileData.location,
                textStyle: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
                hintSemantics: "local",
                tooltipSemantics: "local",
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: SizedBox(
              width: size.width * 0.7,
              child: Center(
                child: GestureDetector(
                  onTap: () {},
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
