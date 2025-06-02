import 'package:flutter/material.dart';

enum DeviceScreenType { mobile, tablet, desktop }

class ResponsiveUtils {
  const ResponsiveUtils._();

  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 950.0;
  static const double desktopBreakpoint = 1200.0;

  static DeviceScreenType getDeviceType(BoxConstraints constraints) {
    if (constraints.maxWidth >= tabletBreakpoint) {
      return DeviceScreenType.desktop;
    } else if (constraints.maxWidth >= mobileBreakpoint) {
      return DeviceScreenType.tablet;
    } else {
      return DeviceScreenType.mobile;
    }
  }

  static double thirtyPercentScreenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width * 0.3;
  }

  static double halfScreenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width / 2;
  }

  static double fullScreenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double fullScreenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static double halfScreenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height / 2;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static double screenPaddingTop(BuildContext context) {
    return MediaQuery.paddingOf(context).top;
  }

  static double screenPaddingBottom(BuildContext context) {
    return MediaQuery.paddingOf(context).bottom;
  }

  static double screenPaddingLeft(BuildContext context) {
    return MediaQuery.paddingOf(context).left;
  }

  static double screenPaddingRight(BuildContext context) {
    return MediaQuery.paddingOf(context).right;
  }

  static double screenPaddingHorizontal(BuildContext context) {
    return MediaQuery.paddingOf(context).left +
        MediaQuery.paddingOf(context).right;
  }

  static double screenPaddingVertical(BuildContext context) {
    return MediaQuery.paddingOf(context).top +
        MediaQuery.paddingOf(context).bottom;
  }

  static double screenPadding(BuildContext context) {
    return MediaQuery.paddingOf(context).top +
        MediaQuery.paddingOf(context).bottom +
        MediaQuery.paddingOf(context).left +
        MediaQuery.paddingOf(context).right;
  }

  static double screenAspectRatio(BuildContext context) {
    return MediaQuery.sizeOf(context).width / MediaQuery.sizeOf(context).height;
  }

  static double screenDevicePixelRatio(BuildContext context) {
    return MediaQuery.devicePixelRatioOf(context);
  }

  static double screenMinWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).shortestSide;
  }

  static double screenMaxWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).longestSide;
  }

  static double screenOrientation(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.portrait
        ? 1.0
        : 2.0;
  }

  static double screenSize(BuildContext context) {
    return MediaQuery.sizeOf(context).width * MediaQuery.sizeOf(context).height;
  }

  static double screenWidthPercentage(BuildContext context, double percentage) {
    return MediaQuery.sizeOf(context).width * (percentage / 100);
  }

  static double screenHeightPercentage(
    BuildContext context,
    double percentage,
  ) {
    return MediaQuery.sizeOf(context).height * (percentage / 100);
  }

  static double screenPaddingPercentage(
    BuildContext context,
    double percentage,
  ) {
    return MediaQuery.paddingOf(context).top * (percentage / 100) +
        MediaQuery.paddingOf(context).bottom * (percentage / 100) +
        MediaQuery.paddingOf(context).left * (percentage / 100) +
        MediaQuery.paddingOf(context).right * (percentage / 100);
  }

  static double screenAspectRatioPercentage(
    BuildContext context,
    double percentage,
  ) {
    return MediaQuery.sizeOf(context).width /
        MediaQuery.sizeOf(context).height *
        (percentage / 100);
  }

  static double screenDevicePixelRatioPercentage(
    BuildContext context,
    double percentage,
  ) {
    return MediaQuery.devicePixelRatioOf(context) * (percentage / 100);
  }

  static double screenMinWidthPercentage(
    BuildContext context,
    double percentage,
  ) {
    return MediaQuery.sizeOf(context).shortestSide * (percentage / 100);
  }

  static double screenMaxWidthPercentage(
    BuildContext context,
    double percentage,
  ) {
    return MediaQuery.sizeOf(context).longestSide * (percentage / 100);
  }

  static double screenOrientationPercentage(
    BuildContext context,
    double percentage,
  ) {
    return MediaQuery.orientationOf(context) == Orientation.portrait
        ? 1.0 * (percentage / 100)
        : 2.0 * (percentage / 100);
  }

  static double screenSizePercentage(BuildContext context, double percentage) {
    return MediaQuery.sizeOf(context).width *
        MediaQuery.sizeOf(context).height *
        (percentage / 100);
  }

  static bool isMobile(double width) {
    return width < mobileBreakpoint;
  }

  static bool isTablet(double width) {
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  static bool isDesktop(double width) {
    return width >= tabletBreakpoint && width < desktopBreakpoint;
  }
}
