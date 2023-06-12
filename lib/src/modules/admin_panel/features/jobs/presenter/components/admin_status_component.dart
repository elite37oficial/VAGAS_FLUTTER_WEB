import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';
import 'package:vagas_flutter_web/src/shared/responsive/sizer.dart';

class AdminStatusComponent extends StatelessWidget {
  final String status;
  const AdminStatusComponent({Key? key, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizer.calculateVertical(context, 20) <= 25
          ? 25
          : Sizer.calculateVertical(context, 20),
      width: Sizer.calculateHorizontal(context, 20) <= 60
          ? 60
          : Sizer.calculateHorizontal(context, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: _getStatusColor(status),
      ),
      child: Center(child: _getLabel(context: context, status: status)),
    );
  }
}

Color _getStatusColor(String status) {
  if (status == "Active") {
    return AppColors.darkBlue.withOpacity(0.1);
  } else if (status == "Closed") {
    return AppColors.lightGrey.withOpacity(0.1);
  } else if (status == "Canceled") {
    return AppColors.red.withOpacity(0.1);
  } else {
    return AppColors.lightGrey.withOpacity(0.1);
  }
}

ResponsiveTextWidget _getLabel(
    {required String status, required BuildContext context}) {
  if (status == "Active") {
    return ResponsiveTextWidget(
      text: "Active",
      textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w700,
          ),
      maxFontSize: 12,
      minFontSize: 7,
      maxLines: 1,
    );
  } else if (status == "Closed") {
    return ResponsiveTextWidget(
      text: "Closed",
      textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: AppColors.black.withOpacity(0.5),
            fontWeight: FontWeight.w700,
          ),
      maxFontSize: 12,
      minFontSize: 7,
      maxLines: 1,
    );
  } else if (status == "Canceled") {
    return ResponsiveTextWidget(
      text: "Canceled",
      textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: AppColors.red,
            fontWeight: FontWeight.w700,
          ),
      maxFontSize: 12,
      minFontSize: 7,
      maxLines: 1,
    );
  } else {
    return ResponsiveTextWidget(
      text: "Closed",
      textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: AppColors.black.withOpacity(0.5),
            fontWeight: FontWeight.w700,
          ),
      maxFontSize: 12,
      minFontSize: 7,
      maxLines: 1,
    );
  }
}
