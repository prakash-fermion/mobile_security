import 'package:equatable/equatable.dart';
import 'package:flutter_sim_data/sim_data_model.dart';

abstract class SimBindingState extends Equatable {
  const SimBindingState();

  @override
  List<Object> get props => [];
}

class SimBindingInitial extends SimBindingState {}

class SimBindingLoading extends SimBindingState {}

class SimBindingSuccess extends SimBindingState {
  final List<SimDataModel> simData;

  const SimBindingSuccess(this.simData);

  @override
  List<Object> get props => [simData];
}

class SimBindingFailure extends SimBindingState {
  final String error;

  const SimBindingFailure(this.error);

  @override
  List<Object> get props => [error];
}
