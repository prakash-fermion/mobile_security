import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_security/config/router/route_name.dart';
import 'package:mobile_security/prakash/core/utils/responsive_utils.dart';

class HomeDesktopWidget extends StatelessWidget {
  const HomeDesktopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: [
        InkWell(
          onTap: () {
            context.pushNamed(RouteName.simBindingRoute);
          },
          child: Card(
            child: Container(
              width: ResponsiveUtils.thirtyPercentScreenWidth(context),
              padding: const EdgeInsets.all(16.0),
              height: 150,
              alignment: Alignment.center,
              child: Text(
                'SIM/Device Binding',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),

        InkWell(
          onTap: () {
            context.pushNamed(RouteName.fixedDepositCalculatorRoute);
          },
          child: Card(
            child: Container(
              width: ResponsiveUtils.thirtyPercentScreenWidth(context),
              height: 150,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Fixed Deposit Calculator',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            context.pushNamed(RouteName.rdCalculatorRoute);
          },
          child: Card(
            child: Container(
              width: ResponsiveUtils.thirtyPercentScreenWidth(context),
              height: 150,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'RD Calculator',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            context.pushNamed(RouteName.dynamicFormRoute);
          },
          child: Card(
            child: Container(
              width: ResponsiveUtils.thirtyPercentScreenWidth(context),
              height: 150,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Data driven forms',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
