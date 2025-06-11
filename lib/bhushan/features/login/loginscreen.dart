import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobile_security/bhushan/core/route/routename.dart';
import 'package:mobile_security/bhushan/core/utils/errordialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  final List<TextEditingController> _mpinControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  bool _isBiometricAvailable = false;
  bool _isBiometricFailed = false;
  String _errorMessage = '';

  bool? isDeveloperModeEnabled;

  Future<void> _checkDeveloperMode() async {
    bool developerMode = false;

    if (Theme.of(context).platform == TargetPlatform.android) {
      developerMode =
          await await JailbreakRootDetection
              .instance
              .isDevMode; // android only.

      // final androidInfo = await deviceInfo.androidInfo;
      // developerMode = androidInfo.isPhysicalDevice == false;
    }

    setState(() {
      if (developerMode) {
        print("developer mode is enabled");

        showDialog(
          context: context,
          builder:
              (context) => ErrorDialog(
                message:
                    'Developer mode is enabled. Please disable it to continue.',
              ),
        );
      } else {
        _authenticateWithBiometrics();
      }
      isDeveloperModeEnabled = developerMode;
    });
  }

  @override
  void initState() {
    _authenticateWithBiometrics();

    super.initState();
  }

  Future<void> _authenticateWithBiometrics() async {
    try {
      bool isAvailable = await _localAuth.canCheckBiometrics;
      if (isAvailable) {
        bool authenticated = await _localAuth.authenticate(
          localizedReason: 'Authenticate using your fingerprint',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );
        if (authenticated) {
          _onAuthenticationSuccess();
        } else {
          setState(() {
            _isBiometricFailed = true;
          });
        }
      } else {
        setState(() {
          _isBiometricAvailable = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Biometric authentication failed: $e';
        _isBiometricFailed = true;
      });
    }
  }

  @override
  void didChangeDependencies() {
    // _checkDeveloperMode();
    super.didChangeDependencies();
  }

  void _onAuthenticationSuccess() {
    // Navigator.pushReplacementNamed(context, RouteName.home);
    Navigator.pushNamed(context, RouteName.simBinding);
  }

  void _validateMPIN() {
    String enteredMPIN = _mpinControllers.map((c) => c.text).join();
    const String correctMPIN = '123456';

    if (enteredMPIN == correctMPIN) {
      _onAuthenticationSuccess();
    } else {
      setState(() {
        _errorMessage = 'Invalid MPIN. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isBiometricFailed)
                    Column(
                      children: [
                        InkWell(
                          onTap: _authenticateWithBiometrics,
                          child: const Icon(
                            Icons.fingerprint,
                            size: 80,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Authenticate using Biometrics',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              _errorMessage,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        const Text(
                          'Enter 6-digit MPIN',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(6, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: SizedBox(
                                width: 40,
                                child: TextField(
                                  controller: _mpinControllers[index],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty && index < 5) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _validateMPIN,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              _errorMessage,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
