import 'package:equatable/equatable.dart';

class FormEntity extends Equatable {
  final String? inputType;
  final String? widget;
  final String? regex;
  final AttributesEnitity? attributesEntity;

  const FormEntity({
    this.inputType,
    this.widget,
    this.regex,
    this.attributesEntity,
  });

  @override
  List<Object?> get props => [inputType, widget, regex, attributesEntity];
}

class AttributesEnitity extends Equatable {
  final String? label;
  final String? hint;
  final String? required;
  final String? enabled;
  final String? maxLength;
  final String? keyboardType;
  final String? obscureText;
  final String? maxLines;
  final String? useDatePicker;
  final String? dateFormat;
  final String? useTimePicker;
  final String? timeFormat;
  final String? items;
  final String? tristate;
  final String? min;
  final String? max;
  final String? divisions;
  final String? options;

  const AttributesEnitity({
    this.label,
    this.hint,
    this.required,
    this.enabled,
    this.maxLength,
    this.keyboardType,
    this.obscureText,
    this.maxLines,
    this.useDatePicker,
    this.dateFormat,
    this.useTimePicker,
    this.timeFormat,
    this.items,
    this.tristate,
    this.min,
    this.max,
    this.divisions,
    this.options,
  });

  @override
  List<Object?> get props => [
    label,
    hint,
    required,
    enabled,
    maxLength,
    keyboardType,
    obscureText,
    maxLines,
    useDatePicker,
    dateFormat,
    useTimePicker,
    timeFormat,
    items,
    tristate,
    min,
    max,
    divisions,
    options,
  ];
}
