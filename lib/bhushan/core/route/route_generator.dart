import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_security/bhushan/core/route/routename.dart';
import 'package:mobile_security/bhushan/features/developer_mode/developer_mode_screen.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/bloc/dynamic_form_bloc.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/presentation/screen/dynamic_form_page.dart';
import 'package:mobile_security/bhushan/features/home/homepage.dart';
import 'package:mobile_security/bhushan/features/login/loginscreen.dart';
import 'package:mobile_security/bhushan/features/sim_binding/bloc/sim_binding_bloc.dart';
import 'package:mobile_security/bhushan/features/sim_binding/presentation/sim_binding_screen.dart';

import '../di/injection.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.initial:
        return MaterialPageRoute(builder: (_) => DeveloperModeScreen());
        case RouteName.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RouteName.simBinding:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => SimBindingBloc(),
                child: const SimBindingScreen(),
              ),
        );
      case RouteName.home:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => DynamicFormBloc(apiService: sl()),
                child: const HomePage(),
              ),
        );
      case RouteName.dynamicFormPage:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => DynamicFormBloc(apiService: sl()),
                child: const DynamicFormPage(),
              ),
        );

      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
