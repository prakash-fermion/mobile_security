import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_security/config/router/route_name.dart';
import 'package:mobile_security/prakash/core/utils/custom_logger.dart';
import 'package:mobile_security/prakash/core/utils/utils.dart';
import 'package:mobile_security/prakash/features/auth/presentation/bloc/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _mpinController = TextEditingController();

  void _register() {
    if (_formKey.currentState!.validate()) {
      // Handle registration logic here
      CustomLogger.info('Username: ${_usernameController.text}');
      CustomLogger.info('Password: ${_passwordController.text}');
      CustomLogger.info('MPIN: ${_mpinController.text}');

      if (_usernameController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _mpinController.text.isEmpty) {
        CustomLogger.error('Username, Password or MPIN cannot be empty');
        Utils.showSnackBar(
          context: context,
          message: 'Username, Password or MPIN cannot be empty',
        );
      } else {
        context.read<AuthBloc>().add(
          AuthRegisterEvent(
            username: _usernameController.text.trim(),
            password: _passwordController.text.trim(),
            mpin: _mpinController.text.trim(),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 8,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 8,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _mpinController,
                  maxLength: 6,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'MPIN',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a MPIN';
                    }
                    return null;
                  },
                ),
            
                SizedBox(height: 16),
            
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthRegistered) {
                      context.goNamed(RouteName.homeRoute);
                      Utils.showSuccessSnackBar(
                        context: context,
                        message: 'Successfully Registered',
                      );
                    } else if (state is AuthFailure) {
                      Utils.showErrorSnackBar(
                        context: context,
                        message: state.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    return Center(
                      child:
                          state is AuthLoading
                              ? CircularProgressIndicator.adaptive()
                              : ElevatedButton(
                                onPressed: () {
                                  _register();
                                },
                                child: Text('Register'),
                              ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
