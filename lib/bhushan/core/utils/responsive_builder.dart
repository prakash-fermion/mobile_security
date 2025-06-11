import 'package:flutter/material.dart';

import 'responsive_utils.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = ResponsiveUtils.getDeviceType(constraints);
        switch (deviceType) {
          case DeviceScreenType.desktop:
            return desktop;
          case DeviceScreenType.tablet:
            return tablet ?? desktop;
          case DeviceScreenType.mobile:
            return mobile;
        }
      },
    );
  }
}
