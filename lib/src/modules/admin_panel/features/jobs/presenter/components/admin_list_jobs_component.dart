import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/presenter/components/admin_job_tile_component.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';

class AdminListJobsComponent extends StatelessWidget {
  final List<JobEntity> listJobs;
  final String token;
  const AdminListJobsComponent(
      {Key? key, required this.listJobs, required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return listJobs.isEmpty
        ? Center(
            child: ResponsiveTextWidget(
              text:
                  "Você ainda não possui vagas publicadas, clique no botão abaixo para publicar.",
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
              itemCount: listJobs.length,
              itemBuilder: (context, index) {
                return AdminJobTileComponent(
                  token: token,
                  index: index,
                  jobTileData: listJobs[index],
                );
              },
            ),
          );
  }
}
