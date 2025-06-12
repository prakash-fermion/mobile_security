part of 'dynamic_form_bloc.dart';

abstract class DynamicFormState extends Equatable {
  const DynamicFormState();

  @override
  List<Object> get props => [];
}

class DynamicFormInitial extends DynamicFormState {}

class DynamicFormLoading extends DynamicFormState {}

class DynamicFormLoaded extends DynamicFormState {
  final List<FormEntity> formList;

  const DynamicFormLoaded(this.formList);

  @override
  List<Object> get props => [formList];
}

class DynamicFormFailure extends DynamicFormState {
  final String message;

  const DynamicFormFailure(this.message);

  @override
  List<Object> get props => [message];
}
