import 'package:equatable/equatable.dart';

class CalculationRequestEntity extends Equatable {
  final int principalAmount;
  final double interestRate;
  final double tenure;

  const CalculationRequestEntity({
    required this.principalAmount,
    required this.interestRate,
    required this.tenure,
  });

  @override
  List<Object?> get props => [principalAmount, interestRate, tenure];
}
