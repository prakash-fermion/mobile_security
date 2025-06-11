import 'dart:convert';

class DynamicFormModel {
  final String inputType;
  final String widget;
  final String regex;
  final Attributes attributes;

  DynamicFormModel({
    required this.inputType,
    required this.widget,
    required this.regex,
    required this.attributes,
  });

  factory DynamicFormModel.fromJson(Map<String, dynamic> json) {
    return DynamicFormModel(
      inputType: json['inputType'],
      widget: json['widget'],
      regex: json['regex'],
      attributes: Attributes.fromJson(json['attributes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'inputType': inputType,
      'widget': widget,
      'regex': regex,
      'attributes': attributes.toJson(),
    };
  }
}

class Attributes {
  final String label;
  final String hint;
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

  Attributes({
    required this.label,
    required this.hint,
    required this.required,
    required this.enabled,
    this.maxLength,
    this.keyboardType,
    required this.obscureText,
    this.maxLines,
    required this.useDatePicker,
    this.dateFormat,
    required this.useTimePicker,
    this.timeFormat,
    this.items,
    this.tristate,
    this.min,
    this.max,
    this.divisions,
    this.options,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      label: json['label'],
      hint: json['hint'],
      required: json['required'],
      enabled: json['enabled'],
      maxLength: json['maxLength'],
      keyboardType: json['keyboardType'],
      obscureText: json['obscureText'],
      maxLines: json['maxLines'],
      useDatePicker: json['useDatePicker'],
      dateFormat: json['dateFormat'],
      useTimePicker: json['useTimePicker'],
      timeFormat: json['timeFormat'],
      items: json['items'] as String,
      tristate: json['tristate'],
      min: json['min'],
      max: json['max'],
      divisions: json['divisions'],
      options: json['options'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'hint': hint,
      'required': required.toString(),
      'enabled': enabled.toString(),
      'maxLength': maxLength?.toString(),
      'keyboardType': keyboardType,
      'obscureText': obscureText.toString(),
      'maxLines': maxLines?.toString(),
      'useDatePicker': useDatePicker.toString(),
      'dateFormat': dateFormat,
      'useTimePicker': useTimePicker.toString(),
      'timeFormat': timeFormat,
      'items': items.toString(),
      'tristate': tristate?.toString(),
      'min': min?.toString(),
      'max': max?.toString(),
      'divisions': divisions?.toString(),
      'options': options != null ? jsonEncode(options) : null,
    };
  }
}

class Item {
  final String value;
  final String label;

  Item({required this.value, required this.label});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(value: json['value'], label: json['label']);
  }

  Map<String, dynamic> toJson() {
    return {'value': value, 'label': label};
  }
}
