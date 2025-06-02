part of 'fixed_deposit_calculator_bloc.dart';

abstract class FixedDepositCalculatorEvent extends Equatable {
  const FixedDepositCalculatorEvent();

  @override
  List<Object> get props => [];
}

class FetchCitizenListEvent extends FixedDepositCalculatorEvent {}

class FetchInterestRateEvent extends FixedDepositCalculatorEvent {}

class CalculateFixedDepositEvent extends FixedDepositCalculatorEvent {
  final CalculationRequestEntity calculationRequest;

  const CalculateFixedDepositEvent({required this.calculationRequest});

  @override
  List<Object> get props => [calculationRequest];
}
