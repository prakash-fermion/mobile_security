part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SendOtpEvent extends HomeEvent {
  final String phoneNumber;

  const SendOtpEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class VerifyOtpEvent extends HomeEvent {
  final String otp;

  const VerifyOtpEvent({required this.otp});

  @override
  List<Object> get props => [otp];
}

class VerifySimBindingEvent extends HomeEvent {
  final String deviceId;
  final String mobileNumber;

  const VerifySimBindingEvent({
    required this.deviceId,
    required this.mobileNumber,
  });

  @override
  List<Object> get props => [deviceId, mobileNumber];
}

class CheckSimBindingStatusEvent extends HomeEvent {
  final String deviceId;

  const CheckSimBindingStatusEvent({required this.deviceId});

  @override
  List<Object> get props => [deviceId];
}
