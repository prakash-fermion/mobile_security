import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_security/config/router/route_name.dart';
import 'package:mobile_security/prakash/core/utils/custom_logger.dart';
import 'package:mobile_security/prakash/core/utils/platform_channel_utility.dart';
import 'package:mobile_security/prakash/core/utils/responsive_builder.dart';
import 'package:mobile_security/prakash/core/utils/utils.dart';
import 'package:mobile_security/prakash/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_security/prakash/features/home/presentation/widgets/home_desktop_widget.dart';
import 'package:mobile_security/prakash/features/home/presentation/widgets/home_mobile_widget.dart';
import 'package:mobile_security/prakash/features/home/presentation/widgets/home_tablet_widget.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  void _checkDebugger() async {
    String message = '';
    bool jailbroken = await FlutterJailbreakDetection.jailbroken;
    bool devMode = await FlutterJailbreakDetection.developerMode;
    CustomLogger.info('Jailbreak: $jailbroken --- Developer Mode: $devMode');

    bool isDebug = await PlatformChannelUtility.isDebuggerAttached();
    CustomLogger.info('Debugger attached: $isDebug');

    if (jailbroken) {
      message = 'Jailbreak detected';
    } else if (devMode || isDebug) {
      message = 'Developer Mode or Debugger attached';
    }

    if (isDebug || jailbroken || devMode) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Warning'),
            content: Text(message),
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
      // _checkDebugger();
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ResponsiveBuilder(
          mobile: HomeMobileWidget(),
          tablet: HomeTabletWidget(),
          desktop: HomeDesktopWidget(),
        ),
      ),
    );
  }
}
