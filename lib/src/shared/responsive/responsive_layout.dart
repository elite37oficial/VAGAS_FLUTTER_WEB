import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  final Widget? largeDesktop;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
    this.largeDesktop,
  }) : super(key: key);

  static double mobileWidthBreakpoint = 414;
  static double tabletWidthBreakpoint = 601;
  static double desktopWidthBreakpoint = 1366;
  static double largeDesktopWidthBreakpoint = 1800;

  static double mobileHeightBreakpoint = 896;
  static double tabletHeightBreakpoint = 962;
  static double desktopHeightBreakpoint = 768;
  static double largeDesktopHeightBreakpoint = 870;

  static double widthBreakpointHelper(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (size.width >= largeDesktopWidthBreakpoint) {
      return largeDesktopWidthBreakpoint;
    } else if (size.width >= desktopWidthBreakpoint &&
        size.width < largeDesktopWidthBreakpoint) {
      return desktopWidthBreakpoint;
    } else if (size.width < desktopWidthBreakpoint &&
        size.width >= tabletWidthBreakpoint) {
      return tabletWidthBreakpoint;
    } else {
      return mobileWidthBreakpoint;
    }
  }

  static double heightBreakpointHelper(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (size.height >= largeDesktopHeightBreakpoint) {
      return largeDesktopHeightBreakpoint;
    } else if (size.height >= tabletHeightBreakpoint &&
        size.height < largeDesktopHeightBreakpoint) {
      return tabletHeightBreakpoint;
    } else if (size.height >= desktopHeightBreakpoint &&
        size.height < tabletHeightBreakpoint) {
      return desktopHeightBreakpoint;
    } else {
      return mobileHeightBreakpoint;
    }
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileWidthBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletWidthBreakpoint &&
      MediaQuery.of(context).size.width >= mobileWidthBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopWidthBreakpoint &&
      MediaQuery.of(context).size.width < largeDesktopWidthBreakpoint;

  static bool isLargeDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= largeDesktopWidthBreakpoint;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget layout = desktop;
    if (size.width >= largeDesktopWidthBreakpoint) {
      return largeDesktop ?? layout;
    } else if (size.width >= desktopWidthBreakpoint &&
        size.width < largeDesktopWidthBreakpoint) {
      return desktop;
    } else if (size.width >= tabletWidthBreakpoint &&
        size.width < desktopWidthBreakpoint) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }
}
