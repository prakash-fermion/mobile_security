import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_security/prakash/core/constants/app_strings.dart';
import 'package:mobile_security/prakash/features/dynamic_form/domain/entities/form_entity.dart';
import 'package:mobile_security/prakash/features/dynamic_form/domain/usecases/get_dynamic_form_list_usecase.dart';

part 'dynamic_form_event.dart';
part 'dynamic_form_state.dart';

class DynamicFormBloc extends Bloc<DynamicFormEvent, DynamicFormState> {
  final GetDynamicFormListUsecase getDynamicFormListUsecase;

  DynamicFormBloc({required this.getDynamicFormListUsecase,}) : super(DynamicFormInitial()) {
    on<GetDynamicFormListEvent>(_getDynamicFormListEvent);
  }

  FutureOr<void> _getDynamicFormListEvent(GetDynamicFormListEvent event, Emitter<DynamicFormState> emit) async{
    emit(DynamicFormLoading());
    final dynamicFormList = await getDynamicFormListUsecase();
    dynamicFormList.fold(
      (failure) => emit(DynamicFormFailure(failure.message ?? AppStrings.defaultErrorMessage)),
      (formList) => emit(DynamicFormLoaded(formList)),
    );
  }
}
