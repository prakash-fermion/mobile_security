import 'package:dartz/dartz.dart';
import 'package:mobile_security/prakash/core/error/failure.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/entities/interest_rate_entity.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/repositories/fixed_deposit_calculator_repository.dart';

class GetInterestRateListUsecase {
  final FixedDepositCalculatorRepository fixedDepositCalculatorRepository;

  GetInterestRateListUsecase(this.fixedDepositCalculatorRepository);

  Future<Either<Failure, List<InterestRateEntity>>> call() async {
    return await fixedDepositCalculatorRepository.getInterestRateList();
  }
}
