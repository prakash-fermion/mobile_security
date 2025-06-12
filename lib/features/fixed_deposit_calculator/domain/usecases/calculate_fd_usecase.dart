import 'package:dartz/dartz.dart';
import 'package:mobile_security/core/error/failure.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/entities/calculation_entity.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/entities/calculation_request_entity.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/repositories/fixed_deposit_calculator_repository.dart';

class CalculateFdUsecase {
  final FixedDepositCalculatorRepository fixedDepositCalculatorRepository;
  CalculateFdUsecase(this.fixedDepositCalculatorRepository);

  Future<Either<Failure, CalculationEntity>> call(
    CalculationRequestEntity calculationRequestEntity,
  ) async {
    return await fixedDepositCalculatorRepository.calculateFd(
      calculationRequestEntity,
    );
  }
}
