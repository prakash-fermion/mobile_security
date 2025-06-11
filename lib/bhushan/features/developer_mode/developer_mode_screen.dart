import 'package:flutter/material.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:mobile_security/bhushan/core/route/routename.dart';

class DeveloperModeScreen extends StatefulWidget {
  const DeveloperModeScreen({super.key});

  @override
  State<DeveloperModeScreen> createState() => _DeveloperModeScreenState();
}

class _DeveloperModeScreenState extends State<DeveloperModeScreen> {

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
    if (!isDeveloperModeEnabled) {
      Navigator.pushReplacementNamed(context, RouteName.login);
    }
  }

  @override
  void didChangeDependencies() {
    _checkDeveloperMode();
    super.didChangeDependencies();
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Mode Alert'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 100,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 20),
            const Text(
              'Developer Mode is ON',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please turn off Developer Mode to use the app.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),

          ],
        ),
      ),
    );
  }
}
