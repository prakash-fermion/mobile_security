import 'package:flutter/material.dart';
import 'package:mobile_security/prakash/config/router/route_config.dart';
import 'package:mobile_security/prakash/core/di/injection.dart';
import 'package:no_screenshot/no_screenshot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoScreenshot.instance.screenshotOff();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Banking App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: RouteConfig.goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
