import 'dart:math';

import 'package:mobile_security/core/utils/custom_logger.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/data/datasources/local/fixed_deposit_calculator_local_datasource.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/entities/calculation_entity.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/entities/calculation_request_entity.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/entities/dropdown_entity.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/entities/interest_rate_entity.dart';

class FixedDepositCalculatorLocalDatasourceImpl
    extends FixedDepositCalculatorLocalDatasource {
  @override
  Future<List<DropdownEntity>> getCitizenDropdownList() async {
    return [
      DropdownEntity(label: 'Yes', code: 'YES'),
      DropdownEntity(label: 'No', code: 'NO'),
    ];
  }

  @override
  Future<List<InterestRateEntity>> getInterestRateList() async {
    return [
      InterestRateEntity(
        tenureLabel: '5Y',
        tenure: 5,
        seniorInterestRate: 8.25,
        junioInterestRate: 7.75,
      ),
      InterestRateEntity(
        tenureLabel: '4Y',
        tenure: 4,
        seniorInterestRate: 8.5,
        junioInterestRate: 8,
      ),
      InterestRateEntity(
        tenureLabel: '3Y',
        tenure: 3,
        seniorInterestRate: 8.75,
        junioInterestRate: 8.25,
      ),
      InterestRateEntity(
        tenureLabel: '2Y 6M',
        tenure: 2.5,
        seniorInterestRate: 8.75,
        junioInterestRate: 8.25,
      ),
      InterestRateEntity(
        tenureLabel: '2Y',
        tenure: 2,
        seniorInterestRate: 8.75,
        junioInterestRate: 8.25,
      ),
      InterestRateEntity(
        tenureLabel: '1Y 6M',
        tenure: 1.5,
        seniorInterestRate: 8,
        junioInterestRate: 7.5,
      ),
      InterestRateEntity(
        tenureLabel: '1Y',
        tenure: 1,
        seniorInterestRate: 6.75,
        junioInterestRate: 6.25,
      ),
    ];
  }

  @override
  Future<CalculationEntity> calculateFd(
    CalculationRequestEntity calculationRequestEntity,
  ) async {
    int n = 4; // Number of times interest is compounded per year
    final rate =
        calculationRequestEntity.interestRate /
        100; // Convert percentage to decimal
    final result =
        calculationRequestEntity.principalAmount *
        pow((1 + rate / n), (n * calculationRequestEntity.tenure));
    final maturityAmount = result.toInt();
    final interestEarned =
        maturityAmount - calculationRequestEntity.principalAmount;
    CustomLogger.info('Calculated Fixed Deposit Amount: $result');
    return CalculationEntity(
      maturityAmount: maturityAmount,
      interestEarned: interestEarned,
    );
  }
}
