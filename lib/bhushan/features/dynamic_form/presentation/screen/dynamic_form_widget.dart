import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/data/models/dropdown_model.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/data/models/dynamic_form_model.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/presentation/widgets/custom_dropdown_form_field.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/presentation/widgets/custom_radio_button.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/presentation/widgets/custom_slider.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/presentation/widgets/custom_switch.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/presentation/widgets/custom_text_form_field.dart';

import '../../../../core/constants/app_string.dart';
import '../../data/models/dropdown_item_entity.dart';
import '../widgets/custom_autocomplete.dart';
import '../widgets/custom_checkbox.dart';
import '../widgets/custom_range_slider.dart';

class DynamicWidget extends StatefulWidget {
  final DynamicFormModel formEntity;
  final Map<String, dynamic> formData;
  final Function(String label, dynamic value) onUpdate;
  const DynamicWidget({
    super.key,
    required this.formEntity,
    required this.formData,
    required this.onUpdate,
  });

  @override
  State<DynamicWidget> createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget> {
  Widget _getWidget() {
    switch (widget.formEntity.widget) {
      case AppStrings.textFormFieldWidget:
        return CustomTextFormField(
          initialValue:
              widget.formEntity.inputType.toLowerCase() !=
                          AppStrings.dateInputType &&
                      widget.formEntity.inputType.toLowerCase() !=
                          AppStrings.timeInputType
                  ? widget.formData[widget.formEntity.attributes.label]
                  : null,
          controller:
              widget.formEntity.inputType.toLowerCase() ==
                          AppStrings.dateInputType ||
                      widget.formEntity.inputType.toLowerCase() ==
                          AppStrings.timeInputType
                  ? TextEditingController(
                    text:
                        widget.formData[widget.formEntity.attributes.label] ??
                        '',
                  )
                  : null,
          label: widget.formEntity.attributes.label,
          hint: widget.formEntity.attributes.label,
          required: widget.formEntity.attributes.required,
          enabled: widget.formEntity.attributes.enabled,
          maxLength: widget.formEntity.attributes.maxLength,
          keyboardType: widget.formEntity.attributes.keyboardType,
          obscureText: widget.formEntity.attributes.obscureText,
          maxLines: widget.formEntity.attributes.maxLines,
          useDatePicker: widget.formEntity.attributes.useDatePicker,
          dateFormat: widget.formEntity.attributes.dateFormat,
          useTimePicker: widget.formEntity.attributes.useTimePicker,
          timeFormat: widget.formEntity.attributes.timeFormat,
          inputType: widget.formEntity.inputType,
          regex: widget.formEntity.regex,
          onChanged: (value) {
            widget.onUpdate(widget.formEntity.attributes.label, value);
          },
        );
      case AppStrings.dropdownButtonFormFieldWidget:
        final List<DropdownItemEntity> items =
            jsonDecode(widget.formEntity.attributes.items ?? '[]')
                .map<DropdownItemEntity>((item) => DropdownModel.fromJson(item))
                .toList();
        return CustomDropdownFormField(
          label: widget.formEntity.attributes.label,
          hint: widget.formEntity.attributes.hint,
          enabled: widget.formEntity.attributes.enabled,
          required: widget.formEntity.attributes.required,
          selectedValue: widget.formData[widget.formEntity.attributes.label],
          items: items,
          onChanged: (value) {
            widget.onUpdate(widget.formEntity.attributes.label, value);
          },
        );
      case AppStrings.checkboxWidget:
        return CustomCheckbox(
          label: widget.formEntity.attributes.label,
          value: widget.formData[widget.formEntity.attributes.label],
          tristate:
              (widget.formEntity.attributes.tristate?.toLowerCase() == 'true'),
          onChanged: (value) {
            widget.onUpdate(widget.formEntity.attributes.label, value);
          },
        );
      case AppStrings.radioWidget:
        final List<DropdownItemEntity> items =
            jsonDecode(widget.formEntity.attributes.items ?? '[]')
                .map<DropdownItemEntity>((item) => DropdownModel.fromJson(item))
                .toList();
        return CustomRadioButton(
          selectedValue: widget.formData[widget.formEntity.attributes.label],
          enabled: widget.formEntity.attributes.enabled,
          required: widget.formEntity.attributes.required,
          label: widget.formEntity.attributes.label,
          items: items,
          onChanged: (value) {
            widget.onUpdate(widget.formEntity.attributes.label, value);
          },
        );
      case AppStrings.switchWidget:
        return CustomSwitch(
          value: widget.formData[widget.formEntity.attributes.label],
          label: widget.formEntity.attributes.label,
          enabled: widget.formEntity.attributes.enabled,
          required: widget.formEntity.attributes.required,
          onChanged: (value) {
            widget.onUpdate(widget.formEntity.attributes.label, value);
          },
        );
      case AppStrings.sliderWidget:
        return CustomSlider(
          label: widget.formEntity.attributes.label,
          selectedValue: widget.formData[widget.formEntity.attributes.label],
          enabled: widget.formEntity.attributes.enabled,
          min: widget.formEntity.attributes.min ?? '0',
          max: widget.formEntity.attributes.max ?? '100',
          divisions: widget.formEntity.attributes.divisions ?? '10',
          onChanged: (value) {
            widget.onUpdate(widget.formEntity.attributes.label, value);
          },
        );
      case AppStrings.rangeSliderWidget:
        return CustomRangeSlider(
          label: widget.formEntity.attributes.label,
          selectedValues: widget.formData[widget.formEntity.attributes.label],
          enabled: widget.formEntity.attributes.enabled,
          min: widget.formEntity.attributes.min ?? '0',
          max: widget.formEntity.attributes.max ?? '100',
          divisions: widget.formEntity.attributes.divisions ?? '10',
          onChanged: (value) {
            widget.onUpdate(widget.formEntity.attributes.label, value);
          },
        );
      case AppStrings.autocompleteWidget:
        final List<String> options =
            jsonDecode(
              widget.formEntity.attributes.options ?? '[]',
            ).cast<String>();
        return CustomAutocomplete(
          label: widget.formEntity.attributes.label,
          hint: widget.formEntity.attributes.hint,
          enabled: widget.formEntity.attributes.enabled,
          required: widget.formEntity.attributes.required,
          selectedValue: widget.formData[widget.formEntity.attributes.label],
          options: options,
          maxLines: widget.formEntity.attributes.maxLines,
          keyboardType: widget.formEntity.attributes.keyboardType,
          onSelected: (value) {
            widget.onUpdate(widget.formEntity.attributes.label, value);
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: _getWidget(),
    );
  }
}
