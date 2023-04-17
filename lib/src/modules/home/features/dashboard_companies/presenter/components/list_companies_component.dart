import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/presenter/components/company_tile_component.dart';

class ListCompaniesComponent extends StatelessWidget {
  final List<CompanyEntity> listCompanies;
  const ListCompaniesComponent({Key? key, required this.listCompanies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return listCompanies.isEmpty
        ? Center(
            child: ResponsiveTextWidget(
              text:
                  "Você ainda não possui empresas cadastradas, clique no botão abaixo para cadastrar.",
              maxLines: 2,
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
              itemCount: listCompanies.length,
              itemBuilder: (context, index) {
                return CompanyTileComponent(
                  index: index,
                  companyTileData: listCompanies[index],
                );
              },
            ),
          );
  }
}
