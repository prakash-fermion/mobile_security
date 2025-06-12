part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class OtpGenerated extends HomeState {}

class OtpVerified extends HomeState {}

class SimBindingVerified extends HomeState {}

class SimNotBounded extends HomeState {}

class HomeFailure extends HomeState {
  final String message;

  const HomeFailure(this.message);

  @override
  List<Object> get props => [message];
}
