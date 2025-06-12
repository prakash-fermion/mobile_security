part of 'fixed_deposit_calculator_bloc.dart';

abstract class FixedDepositCalculatorState extends Equatable {
  const FixedDepositCalculatorState();

  @override
  List<Object> get props => [];
}

class FixedDepositCalculatorInitial extends FixedDepositCalculatorState {}

class FixedDepositCalculatorLoading extends FixedDepositCalculatorState {}

class FixedDepositCalculatorCitizenLoaded extends FixedDepositCalculatorState {
  final List<DropdownEntity> citizenList;

  const FixedDepositCalculatorCitizenLoaded(this.citizenList);

  @override
  List<Object> get props => [citizenList];
}

class FixedDepositCalculatorInterestRateLoaded
    extends FixedDepositCalculatorState {
  final List<InterestRateEntity> interestRateList;

  const FixedDepositCalculatorInterestRateLoaded(this.interestRateList);

  @override
  List<Object> get props => [interestRateList];
}

class FixedDepositCalculatorFailure extends FixedDepositCalculatorState {
  final String message;

  const FixedDepositCalculatorFailure(this.message);

  @override
  List<Object> get props => [message];
}

class FixedDepositCalculatorSuccess extends FixedDepositCalculatorState {
  final CalculationEntity calculationEntity;
  const FixedDepositCalculatorSuccess(this.calculationEntity);

  @override
  List<Object> get props => [calculationEntity];
}
