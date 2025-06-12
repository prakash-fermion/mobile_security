import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_security/config/router/route_name.dart';

class HomeTabletWidget extends StatelessWidget {
  const HomeTabletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 1.5,
      ),
      children: [
        InkWell(
          onTap: () {
            context.pushNamed(RouteName.simBindingRoute);
          },
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text(
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
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text(
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
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text(
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
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text(
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
