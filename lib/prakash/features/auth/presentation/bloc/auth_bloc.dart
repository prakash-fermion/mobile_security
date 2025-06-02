import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_security/prakash/core/constants/app_strings.dart';
import 'package:mobile_security/prakash/features/auth/domain/usecases/check_login_usecase.dart';
import 'package:mobile_security/prakash/features/auth/domain/usecases/login_usecase.dart';
import 'package:mobile_security/prakash/features/auth/domain/usecases/login_with_mpin_usecase.dart';
import 'package:mobile_security/prakash/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mobile_security/prakash/features/auth/domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckLoginUsecase checkLoginUsecase;
  final RegisterUsecase registerUsecase;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final LoginWithMpinUsecase loginWithMpinUsecase;

  AuthBloc({
    required this.checkLoginUsecase,
    required this.registerUsecase,
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.loginWithMpinUsecase,
  }) : super(AuthInitial()) {
    on<AuthCheckLoginEvent>(_authCheckLoginEvent);
    on<AuthRegisterEvent>(_authRegisterEvent);
    on<AuthLoginEvent>(_authLoginEvent);
    on<AuthLogoutEvent>(_authLogoutEvent);
    on<AuthLoginWithMpinEvent>(_authLoginWithMpinEvent);
  }

  FutureOr<void> _authRegisterEvent(
    AuthRegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 2));

    final result = await registerUsecase(
      username: event.username,
      password: event.password,
      mpin: event.mpin,
    );

    result.fold(
      (failure) {
        emit(AuthFailure(failure.message ?? AppStrings.defaultErrorMessage));
      },
      (success) async {
        emit(AuthRegistered());
      },
    );
  }

  FutureOr<void> _authCheckLoginEvent(
    AuthCheckLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 2));

    final result = await checkLoginUsecase();

    result.fold(
      (failure) {
        emit(AuthLoggedOut());
      },
      (success) async {
        emit(AuthLoggedIn());
      },
    );
  }

  FutureOr<void> _authLoginEvent(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 2));

    final result = await loginUsecase(
      username: event.username,
      password: event.password,
    );

    result.fold(
      (failure) {
        emit(AuthFailure(failure.message ?? AppStrings.defaultErrorMessage));
      },
      (success) async {
        emit(AuthLoggedIn());
      },
    );
  }

  FutureOr<void> _authLogoutEvent(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 2));

    final result = await logoutUsecase();

    result.fold(
      (failure) {
        emit(AuthFailure(failure.message ?? AppStrings.defaultErrorMessage));
      },
      (success) async {
        emit(AuthLoggedOut());
      },
    );
  }

  FutureOr<void> _authLoginWithMpinEvent(
    AuthLoginWithMpinEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 2));

    final result = await loginWithMpinUsecase(event.mpin);

    result.fold(
      (failure) {
        emit(AuthFailure(failure.message ?? AppStrings.defaultErrorMessage));
      },
      (success) {
        if (success) {
          emit(AuthLoggedIn());
        } else {
          emit(AuthFailure('Invalid MPIN'));
        }
      },
    );
  }
}
