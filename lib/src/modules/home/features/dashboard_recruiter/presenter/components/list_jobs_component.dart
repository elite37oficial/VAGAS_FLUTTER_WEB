import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/presenter/components/job_tile_component.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';

class ListJobsComponent extends StatelessWidget {
  final List<JobEntity> listJobs;
  const ListJobsComponent({Key? key, required this.listJobs}) : super(key: key);

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
                return JobTileComponent(
                  index: index,
                  jobTileData: listJobs[index],
                );
              },
            ),
          );
  }
}
