import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_security/features/home/domain/usecases/check_binding_status_usecase.dart';
import 'package:mobile_security/features/home/domain/usecases/verify_sim_binding_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final VerifySimBindingUsecase verifySimBindingUsecase;
  final CheckBindingStatusUseCase checkBindingStatusUseCase;
  HomeBloc({
    required this.verifySimBindingUsecase,
    required this.checkBindingStatusUseCase,
  }) : super(HomeInitial()) {
    on<SendOtpEvent>(_sendOtpEvent);
    on<VerifyOtpEvent>(_verifyOtpEvent);
    on<VerifySimBindingEvent>(_verifySimBindingEvent);
    on<CheckSimBindingStatusEvent>(_checkSimBindingStatusEvent);
  }

  FutureOr<void> _sendOtpEvent(
    SendOtpEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    await Future.delayed(const Duration(seconds: 2));
    emit(OtpGenerated());
  }

  FutureOr<void> _verifyOtpEvent(
    VerifyOtpEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    await Future.delayed(const Duration(seconds: 2));
    emit(OtpVerified());
  }

  FutureOr<void> _verifySimBindingEvent(
    VerifySimBindingEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    await Future.delayed(const Duration(seconds: 2));

    final result = await verifySimBindingUsecase(
      phoneNumber: event.mobileNumber,
      deviceId: event.deviceId,
    );

    result.fold(
      (failure) {
        emit(HomeFailure(failure.message ?? 'Error occurred'));
      },
      (success) async {
        emit(SimBindingVerified());
      },
    );
  }

  FutureOr<void> _checkSimBindingStatusEvent(
    CheckSimBindingStatusEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    await Future.delayed(const Duration(seconds: 2));

    final result = await checkBindingStatusUseCase(event.deviceId);

    result.fold(
      (failure) {
        emit(HomeFailure(failure.message ?? 'Error occurred'));
      },
      (isSimBound) async {
        if (isSimBound) {
          emit(SimBindingVerified());
        } else {
          emit(SimNotBounded());
        }
      },
    );
  }
}
