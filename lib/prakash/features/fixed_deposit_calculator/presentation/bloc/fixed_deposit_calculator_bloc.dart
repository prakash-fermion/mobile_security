import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_security/prakash/core/constants/app_strings.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/entities/calculation_entity.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/entities/calculation_request_entity.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/entities/dropdown_entity.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/entities/interest_rate_entity.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/usecases/calculate_fd_usecase.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/usecases/get_citizen_dropdown_list_usecase.dart';
import 'package:mobile_security/prakash/features/fixed_deposit_calculator/domain/usecases/get_interest_rate_list_usecase.dart';

part 'fixed_deposit_calculator_event.dart';
part 'fixed_deposit_calculator_state.dart';

class FixedDepositCalculatorBloc
    extends Bloc<FixedDepositCalculatorEvent, FixedDepositCalculatorState> {
  final GetCitizenDropdownListUsecase getCitizenDropdownListUsecase;
  final GetInterestRateListUsecase getInterestRateListUsecase;
  final CalculateFdUsecase calculateFdUsecase;

  FixedDepositCalculatorBloc({
    required this.getCitizenDropdownListUsecase,
    required this.getInterestRateListUsecase,
    required this.calculateFdUsecase,
  }) : super(FixedDepositCalculatorInitial()) {
    on<FetchCitizenListEvent>(_fetchCitizenListEvent);
    on<FetchInterestRateEvent>(_fetchInterestRateEvent);
    on<CalculateFixedDepositEvent>(_calculateFixedDepositEvent);
  }

  FutureOr<void> _fetchCitizenListEvent(
    FetchCitizenListEvent event,
    Emitter<FixedDepositCalculatorState> emit,
  ) async {
    emit(FixedDepositCalculatorLoading());
    await Future.delayed(const Duration(seconds: 1));
    final result = await getCitizenDropdownListUsecase();
    result.fold(
      (failure) => emit(
        FixedDepositCalculatorFailure(
          failure.message ?? AppStrings.defaultErrorMessage,
        ),
      ),
      (citizenList) => emit(FixedDepositCalculatorCitizenLoaded(citizenList)),
    );
  }

  FutureOr<void> _fetchInterestRateEvent(
    FetchInterestRateEvent event,
    Emitter<FixedDepositCalculatorState> emit,
  ) async {
    emit(FixedDepositCalculatorLoading());
    await Future.delayed(const Duration(seconds: 1));
    final result = await getInterestRateListUsecase();
    result.fold(
      (failure) => emit(
        FixedDepositCalculatorFailure(
          failure.message ?? AppStrings.defaultErrorMessage,
        ),
      ),
      (interestRateList) =>
          emit(FixedDepositCalculatorInterestRateLoaded(interestRateList)),
    );
  }

  FutureOr<void> _calculateFixedDepositEvent(
    CalculateFixedDepositEvent event,
    Emitter<FixedDepositCalculatorState> emit,
  ) async {
    final result = await calculateFdUsecase(event.calculationRequest);
    result.fold(
      (failure) => emit(
        FixedDepositCalculatorFailure(
          failure.message ?? AppStrings.defaultErrorMessage,
        ),
      ),
      (calculationEntity) =>
          emit(FixedDepositCalculatorSuccess(calculationEntity)),
    );
  }
}
