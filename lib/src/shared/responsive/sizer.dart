import 'package:flutter/material.dart';

abstract class Sizer {
  /// Calculates the [vertical] size of a given widget, [vertical] padding or [vertical] distance between widgets.
  /// It's based on a 414px x 896px screen but it can be changed using the parameter [relativeScreenSize].
  /// To calculate the percent number the relativeSize is divided by the relativeScreenSize.
  /// Afterwards the result is rounded up to 3 decimals (usually the height of the screen has something between three and four decimal places).
  /// Finally the final number is used as a percent value of the actual screensize of the device.
  /// [context] and [relativeSize] are [@required] parameters.

  static double calculateVertical(BuildContext context, double relativeSize,
      {double relativeScreenSize = 896}) {
    MediaQueryData query = MediaQuery.of(context);
    double notRoundedValue = relativeSize / relativeScreenSize;
    double percentage = (notRoundedValue * 1000).ceil() / 1000;
    return query.size.height * percentage;
  }

  /// Calculates the [horizontal] size of a given widget, [horizontal] padding or [horizontal] distance between widgets.
  /// It's based on a 414px x 896px screen but it can be changed using the parameter [relativeScreenSize].
  /// To calculate the percent number the relativeSize is divided by the relativeScreenSize.
  /// Afterwards the result is rounded up to 2 decimals (usually the width of the screen has only three decimal places).
  /// Finally the final number is used as a percent value of the actual screensize of the device.
  /// [context] and [relativeSize] are [@required] parameters.

  static double calculateHorizontal(BuildContext context, double relativeSize,
      {double relativeScreenSize = 414}) {
    MediaQueryData query = MediaQuery.of(context);
    double notRoundedValue = relativeSize / relativeScreenSize;
    double percentage = (notRoundedValue * 100).ceil() / 100;
    return query.size.width * percentage;
  }
}
