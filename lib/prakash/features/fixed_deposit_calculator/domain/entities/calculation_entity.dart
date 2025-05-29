import 'package:equatable/equatable.dart';

class CalculationEntity extends Equatable {
  final int maturityAmount;
  final int interestEarned;

  const CalculationEntity({
    required this.maturityAmount,
    required this.interestEarned,
  });

  @override
  List<Object?> get props => [maturityAmount, interestEarned];
}
