import 'package:equatable/equatable.dart';

class InterestRateEntity extends Equatable {
  final String tenureLabel;
  final double tenure;
  final double seniorInterestRate;
  final double junioInterestRate;

  const InterestRateEntity({
    required this.tenureLabel,
    required this.tenure,
    required this.seniorInterestRate,
    required this.junioInterestRate,
  });
  @override
  List<Object?> get props => [tenure, seniorInterestRate, junioInterestRate];
}
