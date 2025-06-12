import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sim_data/sim_data.dart';

import 'sim_binding_event.dart';
import 'sim_binding_states.dart';

// Events

// Bloc
class SimBindingBloc extends Bloc<SimBindingEvent, SimBindingState> {
  SimBindingBloc() : super(SimBindingInitial()) {
    on<LoadSimBinding>(_onBindSim);
  }

  Future<void> _onBindSim(
    LoadSimBinding event,
    Emitter<SimBindingState> emit,
  ) async {
    emit(SimBindingLoading());
    try {
      // Simulate binding logic
      final sim = SimData();
      final simData = await sim.getSimData();
      emit(SimBindingSuccess(simData));
    } catch (e) {
      emit(SimBindingFailure(e.toString()));
    }
  }
}
