import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class AdminCompanyTileComponent extends StatelessWidget {
  final int index;
  final CompanyEntity companyTileData;
  const AdminCompanyTileComponent(
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
        ],
      ),
    );
  }
}
