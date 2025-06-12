import 'package:dartz/dartz.dart';
import 'package:mobile_security/core/error/failure.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/entities/dropdown_entity.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/repositories/fixed_deposit_calculator_repository.dart';

class GetCitizenDropdownListUsecase {
  final FixedDepositCalculatorRepository fixedDepositCalculatorRepository;
  GetCitizenDropdownListUsecase(this.fixedDepositCalculatorRepository);

  Future<Either<Failure, List<DropdownEntity>>> call() async {
    return await fixedDepositCalculatorRepository.getCitizenDropdownList();
  }
}
