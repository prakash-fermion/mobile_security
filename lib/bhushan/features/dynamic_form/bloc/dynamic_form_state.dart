import 'package:equatable/equatable.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/data/models/dynamic_form_model.dart';

class DynamicFormState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DynamicFormInitial extends DynamicFormState {}

class DynamicFormLoading extends DynamicFormState {}

class DynamicFormLoaded extends DynamicFormState {
  final List<DynamicFormModel> formList;

  DynamicFormLoaded(this.formList);

  @override
  List<Object> get props => [formList];
}

class DynamicFormFailure extends DynamicFormState {
  final String message;

  DynamicFormFailure(this.message);

  @override
  List<Object> get props => [message];
}
