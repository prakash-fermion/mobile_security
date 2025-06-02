// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormModel _$FormModelFromJson(Map<String, dynamic> json) => FormModel(
  inputType: json['inputType'] as String?,
  widget: json['widget'] as String?,
  regex: json['regex'] as String?,
  attributes:
      json['attributes'] == null
          ? null
          : AttributeModel.fromJson(json['attributes'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FormModelToJson(FormModel instance) => <String, dynamic>{
  'inputType': instance.inputType,
  'widget': instance.widget,
  'regex': instance.regex,
  'attributes': instance.attributes?.toJson(),
};

AttributeModel _$AttributeModelFromJson(Map<String, dynamic> json) =>
    AttributeModel(
      label: json['label'] as String?,
      hint: json['hint'] as String?,
      required: json['required'] as String?,
      enabled: json['enabled'] as String?,
      maxLength: json['maxLength'] as String?,
      keyboardType: json['keyboardType'] as String?,
      obscureText: json['obscureText'] as String?,
      maxLines: json['maxLines'] as String?,
      useDatePicker: json['useDatePicker'] as String?,
      dateFormat: json['dateFormat'] as String?,
      useTimePicker: json['useTimePicker'] as String?,
      timeFormat: json['timeFormat'] as String?,
      items: json['items'] as String?,
      tristate: json['tristate'] as String?,
      min: json['min'] as String?,
      max: json['max'] as String?,
      divisions: json['divisions'] as String?,
      options: json['options'] as String?,
    );

Map<String, dynamic> _$AttributeModelToJson(AttributeModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'hint': instance.hint,
      'required': instance.required,
      'enabled': instance.enabled,
      'maxLength': instance.maxLength,
      'keyboardType': instance.keyboardType,
      'obscureText': instance.obscureText,
      'maxLines': instance.maxLines,
      'useDatePicker': instance.useDatePicker,
      'dateFormat': instance.dateFormat,
      'useTimePicker': instance.useTimePicker,
      'timeFormat': instance.timeFormat,
      'items': instance.items,
      'tristate': instance.tristate,
      'min': instance.min,
      'max': instance.max,
      'divisions': instance.divisions,
      'options': instance.options,
    };
