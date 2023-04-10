import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/components/user_tile_component.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';

class ListUsersComponent extends StatelessWidget {
  final List<UserEntity> listUsers;
  const ListUsersComponent({Key? key, required this.listUsers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return listUsers.isEmpty
        ? Center(
            child: ResponsiveTextWidget(
              text: "Nenhum Usuário Encontrado.",
              maxLines: 1,
              maxFontSize: 28,
              minFontSize: 20,
              textStyle: Theme.of(context).textTheme.bodyMedium,
              hintSemantics: "vazio",
              tooltipSemantics: "vazio",
            ),
          )
        : SizedBox(
            width: size.width,
            child: ListView.builder(
              itemCount: listUsers.length,
              itemBuilder: (context, index) {
                return UserTileComponent(
                  index: index,
                  userTileData: listUsers[index],
                );
              },
            ),
          );
  }
}
