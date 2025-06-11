import 'package:flutter/material.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:mobile_security/bhushan/core/di/injection.dart';
import 'package:mobile_security/bhushan/core/route/route_generator.dart';
import 'package:mobile_security/bhushan/features/developer_mode/developer_mode_screen.dart';
import 'package:mobile_security/bhushan/features/login/loginscreen.dart';
import 'package:no_screenshot/no_screenshot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NoScreenshot _noScreenshot = NoScreenshot.instance;

  bool isDeveloperModeEnabled = false;

  Future<void> _checkDeveloperMode() async {
    bool developerMode = false;

    if (Theme.of(context).platform == TargetPlatform.android) {
      developerMode =
       await JailbreakRootDetection
          .instance
          .isDevMode;
    }
      isDeveloperModeEnabled = developerMode;
  }
  @override
  void initState() {
    _checkDeveloperMode();
    // _noScreenshot.screenshotOff();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  DeveloperModeScreen(),
    );
  }
}
