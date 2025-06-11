import 'package:equatable/equatable.dart';

abstract class SimBindingEvent extends Equatable {
  const SimBindingEvent();

  @override
  List<Object?> get props => [];
}

class LoadSimBinding extends SimBindingEvent {}
