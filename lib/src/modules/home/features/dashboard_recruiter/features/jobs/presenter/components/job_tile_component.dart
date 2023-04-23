import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/presenter/components/status_component.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class JobTileComponent extends StatelessWidget {
  final int index;
  final JobEntity jobTileData;
  const JobTileComponent(
      {Key? key, required this.index, required this.jobTileData})
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
                      // child: Image.network(
                      //   jobTileData.imageLogo,
                      // ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ResponsiveTextWidget(
                          text: jobTileData.title,
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          hintSemantics: "titulo",
                          tooltipSemantics: "titulo",
                        ),
                        ResponsiveTextWidget(
                          text: jobTileData.companyId,
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
                child: StatusComponent(status: "jobTileData.status"),
              )),
            ),
          ),
          Flexible(
            flex: 6,
            child: SizedBox(
              width: size.width * 0.7,
              child: Center(
                child: ResponsiveTextWidget(
                  text: "jobTileData.createdAt",
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveTextWidget(
                    text: "${jobTileData.city} - ${jobTileData.state}",
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    hintSemantics: "local",
                    tooltipSemantics: "local",
                  ),
                  ResponsiveTextWidget(
                    text: jobTileData.period,
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    hintSemantics: "periodo",
                    tooltipSemantics: "periodo",
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
