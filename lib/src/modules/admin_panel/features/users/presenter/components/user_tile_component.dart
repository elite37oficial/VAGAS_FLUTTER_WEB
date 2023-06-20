import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/components/status_component.dart';
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
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(userTileData.createdDate);
    String datePaserd =
        "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}";

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
                          text: userTileData.name,
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          hintSemantics: "nome",
                          tooltipSemantics: "nome",
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
                alignment: Alignment.center,
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
                  text: datePaserd,
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
                text: userTileData.email,
                textStyle: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                hintSemantics: "email",
                tooltipSemantics: "email",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
