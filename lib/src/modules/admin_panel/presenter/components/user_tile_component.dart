import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/components/status_component.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class UserTileComponent extends StatelessWidget {
  final int index;
  final UserEntity userTileData;
  const UserTileComponent(
      {Key? key, required this.index, required this.userTileData})
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
                        left: Sizer.calculateHorizontal(context, 10) > 35
                            ? 35
                            : Sizer.calculateHorizontal(context, 10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ResponsiveTextWidget(
                          text: userTileData.profession ?? "",
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          hintSemantics: "titulo",
                          tooltipSemantics: "titulo",
                        ),
                        ResponsiveTextWidget(
                          text: userTileData.username,
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.lightGrey,
                                  ),
                          maxLines: 1,
                          hintSemantics: "empresa",
                          tooltipSemantics: "empresa",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: SizedBox(
              width: size.width * 0.7,
              child: Center(
                  child: Align(
                alignment: Alignment.centerLeft,
                child:
                    StatusComponent(status: userTileData.status ?? "Fechada"),
              )),
            ),
          ),
          Flexible(
            flex: 6,
            child: SizedBox(
              width: size.width * 0.7,
              child: Center(
                child: ResponsiveTextWidget(
                  text: userTileData.createdAt,
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                  hintSemantics: "data de criação",
                  tooltipSemantics: "data de criação",
                ),
              ),
            ),
          ),
          Flexible(
            flex: 12,
            child: SizedBox(
              width: size.width * 0.7,
              child: ResponsiveTextWidget(
                text: userTileData.about ?? "",
                textStyle: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                hintSemantics: "sobre",
                tooltipSemantics: "sobre",
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
                ))),
          ),
        ],
      ),
    );
  }
}
