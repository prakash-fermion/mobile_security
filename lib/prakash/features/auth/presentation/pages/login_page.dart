import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_security/config/router/route_name.dart';
import 'package:mobile_security/prakash/core/utils/utils.dart';
import 'package:mobile_security/prakash/features/auth/presentation/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_usernameController.text.trim().isNotEmpty ||
        _passwordController.text.trim().isNotEmpty) {
      context.read<AuthBloc>().add(
        AuthLoginEvent(
          username: _usernameController.text.trim().toString(),
          password: _passwordController.text.trim().toString(),
        ),
      );
    } else {
      Utils.showErrorSnackBar(
        context: context,
        message: 'Username or Password cannot be empty',
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Banking Login'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                maxLength: 8,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoggedIn) {
                    context.goNamed(RouteName.authRoute);
                  } else if (state is AuthFailure) {
                    Utils.showErrorSnackBar(
                      context: context,
                      message: state.error,
                    );
                  }
                },
                builder: (context, state) {
                  return state is AuthLoading
                      ? Center(child: CircularProgressIndicator.adaptive())
                      : ElevatedButton(
                        onPressed: () {
                          _login();
                        },
                        child: const Text('Login'),
                      );
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  context.pushNamed(RouteName.authRoute);
                },
                icon: const Icon(Icons.fingerprint),
                label: const Text('Login with Biometrics'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.pushNamed(RouteName.registerRoute);
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
