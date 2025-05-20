import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_security/prakash/config/router/route_name.dart';
import 'package:mobile_security/prakash/core/utils/custom_logger.dart';
import 'package:mobile_security/prakash/core/utils/platform_channel_utility.dart';
import 'package:mobile_security/prakash/core/utils/utils.dart';
import 'package:mobile_security/prakash/features/auth/presentation/bloc/auth_bloc.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  void _checkDebugger() async {
    bool isDebug = await PlatformChannelUtility.isDebuggerAttached();
    CustomLogger.info('Debugger attached: $isDebug');
    if (isDebug) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Debugger Attached'),
            content: const Text('Debugger is attached to the app.'),
            actions: [
              TextButton(
                onPressed: () {
                  if (Platform.isIOS) {
                    exit(0);
                  } else if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  }
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    if (Platform.isIOS) {
      //_checkDebugger();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoggedOut) {
                context.goNamed(RouteName.loginRoute);
              } else if (state is AuthFailure) {
                Utils.showErrorSnackBar(context: context, message: state.error);
              }
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthLogoutEvent());
                },
                icon: Icon(Icons.logout),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to the Home Page!'),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(RouteName.simBindingRoute);
              },
              child: const Text('SIM/Device Binding'),
            ),
          ],
        ),
      ),
    );
  }
}
