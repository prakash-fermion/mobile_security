import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_security/prakash/config/router/route_name.dart';
import 'package:mobile_security/prakash/features/auth/presentation/bloc/auth_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedIn) {
          // context.goNamed(RouteName.homeRoute);
          context.goNamed(RouteName.authRoute);
        } else if (state is AuthLoggedOut) {
          context.goNamed(RouteName.loginRoute);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(child: Center(child: FlutterLogo(size: 80))),
        );
      },
    );
  }
}
