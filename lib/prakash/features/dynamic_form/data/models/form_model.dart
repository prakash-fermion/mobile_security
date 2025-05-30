import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_security/prakash/features/dynamic_form/domain/entities/form_entity.dart';

part 'form_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FormModel {
  final String? inputType;
  final String? widget;
  final String? regex;
  final AttributeModel? attributes;

  const FormModel({this.inputType, this.widget, this.regex, this.attributes});

  factory FormModel.fromJson(Map<String, dynamic> json) =>
      _$FormModelFromJson(json);
  Map<String, dynamic> toJson() => _$FormModelToJson(this);

  FormEntity toEntity() {
    return FormEntity(
      inputType: inputType,
      widget: widget,
      regex: regex,
      attributesEntity: attributes?.toEntity(),
    );
  }
}

@JsonSerializable()
class AttributeModel {
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
  const AttributeModel({
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

  factory AttributeModel.fromJson(Map<String, dynamic> json) =>
      _$AttributeModelFromJson(json);
  Map<String, dynamic> toJson() => _$AttributeModelToJson(this);

  AttributesEnitity toEntity() {
    return AttributesEnitity(
      label: label,
      hint: hint,
      required: required,
      enabled: enabled,
      maxLength: maxLength,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      useDatePicker: useDatePicker,
      dateFormat: dateFormat,
      useTimePicker: useTimePicker,
      timeFormat: timeFormat,
      items: items,
      tristate: tristate,
      min: min,
      max: max,
      divisions: divisions,
      options: options,
    );
  }
}
