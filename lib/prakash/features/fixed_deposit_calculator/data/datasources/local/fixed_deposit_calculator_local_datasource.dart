import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/entities/calculation_entity.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/entities/calculation_request_entity.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/entities/dropdown_entity.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/entities/interest_rate_entity.dart';

abstract class FixedDepositCalculatorLocalDatasource {
  Future<List<DropdownEntity>> getCitizenDropdownList();
  Future<List<InterestRateEntity>> getInterestRateList();
  Future<CalculationEntity> calculateFd(CalculationRequestEntity calculationRequestEntity);
}