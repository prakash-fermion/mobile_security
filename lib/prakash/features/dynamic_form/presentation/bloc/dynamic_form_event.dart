part of 'dynamic_form_bloc.dart';

abstract class DynamicFormEvent extends Equatable {
  const DynamicFormEvent();

  @override
  List<Object> get props => [];
}

class GetDynamicFormListEvent extends DynamicFormEvent {
  const GetDynamicFormListEvent();

  @override
  List<Object> get props => [];
}