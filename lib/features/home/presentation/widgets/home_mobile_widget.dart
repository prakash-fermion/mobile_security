import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_security/config/router/route_name.dart';

class HomeMobileWidget extends StatelessWidget {
  const HomeMobileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: ListTile(
            title: const Text('SIM/Device Binding'),
            onTap: () {
              context.pushNamed(RouteName.simBindingRoute);
            },
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Fixed Deposit Calculator'),
            onTap: () {
              context.pushNamed(RouteName.fixedDepositCalculatorRoute);
            },
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('RD Calculator'),
            onTap: () {
              context.pushNamed(RouteName.rdCalculatorRoute);
            },
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Data driven forms'),
            onTap: () {
              context.pushNamed(RouteName.dynamicFormRoute);
            },
          ),
        ),
      ],
    );
  }
}
