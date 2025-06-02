import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobile_security/config/router/route_name.dart';
import 'package:mobile_security/prakash/core/utils/utils.dart';
import 'package:mobile_security/prakash/features/auth/presentation/bloc/auth_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final localAuth = LocalAuthentication();
  final TextEditingController _mpinController = TextEditingController();
  final ValueNotifier<bool> _isBiometricAvailable = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  void _checkBiometrics() async {
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    if (canCheckBiometrics) {
      // Biometrics are available
      _authenticateWithBiometrics();
      _isBiometricAvailable.value = true;
    } else {
      _isBiometricAvailable.value = false;
      // Biometrics are not available
      Utils.showSnackBar(
        context: context,
        message: 'Biometric authentication is not available on this device.',
      );
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    try {
      bool didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate to access this feature',
        options: const AuthenticationOptions(biometricOnly: true),
      );

      if (didAuthenticate) {
        context.goNamed(RouteName.homeRoute);

        Utils.showSuccessSnackBar(
          context: context,
          message: 'Biometric authentication successful!',
        );
      } else {
        // Handle failed authentication
        _isBiometricAvailable.value = false;
        Utils.showErrorSnackBar(
          context: context,
          message: 'Biometric authentication is not available on this device.',
        );
      }
    } catch (e) {
      // Handle errors
      _isBiometricAvailable.value = false;
      Utils.showErrorSnackBar(context: context, message: 'Error: $e');
    }
  }

  void _loginWithMPIN() {
    // Handle MPIN login logic here
    if (_mpinController.text.trim().isNotEmpty) {
      context.read<AuthBloc>().add(
        AuthLoginWithMpinEvent(mpin: _mpinController.text.trim()),
      );
    } else {
      Utils.showSnackBar(context: context, message: 'MPIN cannot be empty');
    }
  }

  @override
  void dispose() {
    _mpinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authentication')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder(
            valueListenable: _isBiometricAvailable,
            builder: (context, isAvailable, _) {
              return isAvailable
                  ? Text('Biometric authentication is available')
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: _mpinController,
                        maxLength: 6,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'MPIN',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthLoggedIn) {
                            context.goNamed(RouteName.homeRoute);
                            Utils.showSuccessSnackBar(
                              context: context,
                              message: 'MPIN login successful!',
                            );
                          } else if (state is AuthFailure) {
                            Utils.showErrorSnackBar(
                              context: context,
                              message: state.error,
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                          return ElevatedButton(
                            onPressed: () {
                              _loginWithMPIN();
                            },
                            child: const Text('Login with MPIN'),
                          );
                        },
                      ),
                    ],
                  );
            },
          ),
        ),
      ),
    );
  }
}
