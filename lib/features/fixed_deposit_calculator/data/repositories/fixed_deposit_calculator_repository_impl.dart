import 'package:dartz/dartz.dart';
import 'package:mobile_security/core/error/failure.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/data/datasources/local/fixed_deposit_calculator_local_datasource.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/entities/calculation_entity.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/entities/calculation_request_entity.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/entities/dropdown_entity.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/entities/interest_rate_entity.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/repositories/fixed_deposit_calculator_repository.dart';

class FixedDepositCalculatorRepositoryImpl
    implements FixedDepositCalculatorRepository {
  final FixedDepositCalculatorLocalDatasource
  fixedDepositCalculatorLocalDatasource;

  FixedDepositCalculatorRepositoryImpl({
    required this.fixedDepositCalculatorLocalDatasource,
  });

  @override
  Future<Either<Failure, List<DropdownEntity>>> getCitizenDropdownList() async {
    try {
      final result =
          await fixedDepositCalculatorLocalDatasource.getCitizenDropdownList();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<InterestRateEntity>>>
  getInterestRateList() async {
    try {
      final result =
          await fixedDepositCalculatorLocalDatasource.getInterestRateList();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CalculationEntity>> calculateFd(
    CalculationRequestEntity calculatetionRequestEntity,
  ) async {
    try {
      final result = await fixedDepositCalculatorLocalDatasource.calculateFd(
        calculatetionRequestEntity,
      );
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
