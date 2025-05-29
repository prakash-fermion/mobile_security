import 'package:dartz/dartz.dart';
import 'package:mobile_security/prakash/core/error/failure.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/entities/calculation_entity.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/entities/calculation_request_entity.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/entities/dropdown_entity.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/entities/interest_rate_entity.dart';

abstract class FixedDepositCalculatorRepository {
  Future<Either<Failure, List<DropdownEntity>>> getCitizenDropdownList();
  Future<Either<Failure, List<InterestRateEntity>>> getInterestRateList();
  Future<Either<Failure, CalculationEntity>> calculateFd(CalculationRequestEntity calculatetionRequestEntity);
}
