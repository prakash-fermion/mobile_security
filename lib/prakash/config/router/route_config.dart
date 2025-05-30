import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_security/prakash/config/router/route_name.dart';
import 'package:flutter/material.dart';
import 'package:mobile_security/prakash/core/di/injection.dart';
import 'package:mobile_security/prakash/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_security/prakash/features/auth/presentation/pages/auth_page.dart';
import 'package:mobile_security/prakash/features/auth/presentation/pages/login_page.dart';
import 'package:mobile_security/prakash/features/auth/presentation/pages/register_page.dart';
import 'package:mobile_security/prakash/features/auth/presentation/pages/splash_screen.dart';
import 'package:mobile_security/prakash/features/dynamic_form/presentation/bloc/dynamic_form_bloc.dart';
import 'package:mobile_security/prakash/features/dynamic_form/presentation/pages/dynamic_form_page.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/presentation/bloc/fixed_deposit_calculator_bloc.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/presentation/pages/fixed_deposite_calculator_page.dart';
import 'package:mobile_security/prakash/features/home/presentation/bloc/home_bloc.dart';
import 'package:mobile_security/prakash/features/home/presentation/pages/home_page_screen.dart';
import 'package:mobile_security/prakash/features/home/presentation/pages/sim_binding_page.dart';

class RouteConfig {
  static GoRouter goRouter = GoRouter(
    routes: [
      GoRoute(
        name: RouteName.initialRoute,
        path: RouteName.initialRoute,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: BlocProvider(
              create:
                  (context) => AuthBloc(
                    checkLoginUsecase: sl(),
                    loginUsecase: sl(),
                    registerUsecase: sl(),
                    logoutUsecase: sl(),
                    loginWithMpinUsecase: sl(),
                  )..add(AuthCheckLoginEvent()),
              child: SplashScreen(),
            ),
          );
        },
      ),

      GoRoute(
        name: RouteName.loginRoute,
        path: RouteName.loginRoute,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: BlocProvider(
              create:
                  (context) => AuthBloc(
                    checkLoginUsecase: sl(),
                    loginUsecase: sl(),
                    registerUsecase: sl(),
                    logoutUsecase: sl(),
                    loginWithMpinUsecase: sl(),
                  ),
              child: LoginPage(),
            ),
          );
        },
      ),

      GoRoute(
        name: RouteName.registerRoute,
        path: RouteName.registerRoute,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: BlocProvider(
              create:
                  (context) => AuthBloc(
                    checkLoginUsecase: sl(),
                    loginUsecase: sl(),
                    registerUsecase: sl(),
                    logoutUsecase: sl(),
                    loginWithMpinUsecase: sl(),
                  ),
              child: RegisterPage(),
            ),
          );
        },
      ),

      GoRoute(
        name: RouteName.homeRoute,
        path: RouteName.homeRoute,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: BlocProvider(
              create:
                  (context) => AuthBloc(
                    checkLoginUsecase: sl(),
                    loginUsecase: sl(),
                    registerUsecase: sl(),
                    logoutUsecase: sl(),
                    loginWithMpinUsecase: sl(),
                  ),
              child: HomePageScreen(),
            ),
          );
        },
      ),
      GoRoute(
        name: RouteName.authRoute,
        path: RouteName.authRoute,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: BlocProvider(
              create:
                  (context) => AuthBloc(
                    checkLoginUsecase: sl(),
                    loginUsecase: sl(),
                    registerUsecase: sl(),
                    logoutUsecase: sl(),
                    loginWithMpinUsecase: sl(),
                  ),
              child: AuthPage(),
            ),
          );
        },
      ),
      GoRoute(
        name: RouteName.simBindingRoute,
        path: RouteName.simBindingRoute,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: BlocProvider(
              create:
                  (context) => HomeBloc(
                    checkBindingStatusUseCase: sl(),
                    verifySimBindingUsecase: sl(),
                  ),
              child: SimBindingPage(),
            ),
          );
        },
      ),
      GoRoute(
        name: RouteName.fixedDepositCalculatorRoute,
        path: RouteName.fixedDepositCalculatorRoute,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: BlocProvider(
              create:
                  (context) => FixedDepositCalculatorBloc(
                    getCitizenDropdownListUsecase: sl(),
                    getInterestRateListUsecase: sl(),
                    calculateFdUsecase: sl(),
                  ),
              child: FixedDepositeCalculatorPage(),
            ),
          );
        },
      ),
      GoRoute(
        name: RouteName.dynamicFormRoute,
        path: RouteName.dynamicFormRoute,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: BlocProvider(
              create:
                  (context) => DynamicFormBloc(getDynamicFormListUsecase: sl()),
              child: DynamicFormPage(),
            ),
          );
        },
      ),
    ],
  );
}
