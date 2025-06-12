import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_security/core/constants/app_strings.dart';
import 'package:mobile_security/features/dynamic_form/data/models/dropdown_model.dart';
import 'package:mobile_security/features/dynamic_form/domain/entities/dropdown_item_entity.dart';
import 'package:mobile_security/features/dynamic_form/domain/entities/form_entity.dart';
import 'package:mobile_security/features/dynamic_form/presentation/widgets/custom_autocomplete.dart';
import 'package:mobile_security/features/dynamic_form/presentation/widgets/custom_checkbox.dart';
import 'package:mobile_security/features/dynamic_form/presentation/widgets/custom_dropdown_form_field.dart';
import 'package:mobile_security/features/dynamic_form/presentation/widgets/custom_radio_button.dart';
import 'package:mobile_security/features/dynamic_form/presentation/widgets/custom_range_slider.dart';
import 'package:mobile_security/features/dynamic_form/presentation/widgets/custom_slider.dart';
import 'package:mobile_security/features/dynamic_form/presentation/widgets/custom_switch.dart';
import 'package:mobile_security/features/dynamic_form/presentation/widgets/custom_text_form_field.dart';

class DynamicWidget extends StatefulWidget {
  final FormEntity formEntity;
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
              widget.formEntity.inputType?.toLowerCase() !=
                          AppStrings.dateInputType &&
                      widget.formEntity.inputType?.toLowerCase() !=
                          AppStrings.timeInputType
                  ? widget.formData[widget.formEntity.attributesEntity?.label ??
                          ''] ??
                      ''
                  : null,
          controller:
              widget.formEntity.inputType?.toLowerCase() ==
                          AppStrings.dateInputType ||
                      widget.formEntity.inputType?.toLowerCase() ==
                          AppStrings.timeInputType
                  ? TextEditingController(
                    text:
                        widget.formData[widget
                                .formEntity
                                .attributesEntity
                                ?.label ??
                            ''] ??
                        '',
                  )
                  : null,
          label: widget.formEntity.attributesEntity?.label,
          hint: widget.formEntity.attributesEntity?.label,
          required: widget.formEntity.attributesEntity?.required,
          enabled: widget.formEntity.attributesEntity?.enabled,
          maxLength: widget.formEntity.attributesEntity?.maxLength,
          keyboardType: widget.formEntity.attributesEntity?.keyboardType,
          obscureText: widget.formEntity.attributesEntity?.obscureText,
          maxLines: widget.formEntity.attributesEntity?.maxLines,
          useDatePicker: widget.formEntity.attributesEntity?.useDatePicker,
          dateFormat: widget.formEntity.attributesEntity?.dateFormat,
          useTimePicker: widget.formEntity.attributesEntity?.useTimePicker,
          timeFormat: widget.formEntity.attributesEntity?.timeFormat,
          inputType: widget.formEntity.inputType,
          regex: widget.formEntity.regex,
          onChanged: (value) {
            widget.onUpdate(
              widget.formEntity.attributesEntity?.label ?? '',
              value,
            );
          },
        );
      case AppStrings.dropdownButtonFormFieldWidget:
        final List<DropdownItemEntity> items =
            jsonDecode(widget.formEntity.attributesEntity?.items ?? '[]')
                .map<DropdownItemEntity>((item) => DropdownModel.fromJson(item))
                .toList();
        return CustomDropdownFormField(
          label: widget.formEntity.attributesEntity?.label,
          hint: widget.formEntity.attributesEntity?.hint,
          enabled: widget.formEntity.attributesEntity?.enabled,
          required: widget.formEntity.attributesEntity?.required,
          selectedValue:
              widget.formData[widget.formEntity.attributesEntity?.label ?? ''],
          items: items,
          onChanged: (value) {
            widget.onUpdate(
              widget.formEntity.attributesEntity?.label ?? '',
              value,
            );
          },
        );
      case AppStrings.checkboxWidget:
        return CustomCheckbox(
          label: widget.formEntity.attributesEntity?.label,
          value:
              widget.formData[widget.formEntity.attributesEntity?.label ?? ''],
          tristate:
              (widget.formEntity.attributesEntity?.tristate?.toLowerCase() ==
                  'true'),
          onChanged: (value) {
            widget.onUpdate(
              widget.formEntity.attributesEntity?.label ?? '',
              value,
            );
          },
        );
      case AppStrings.radioWidget:
        final List<DropdownItemEntity> items =
            jsonDecode(widget.formEntity.attributesEntity?.items ?? '[]')
                .map<DropdownItemEntity>((item) => DropdownModel.fromJson(item))
                .toList();
        return CustomRadioButton(
          selectedValue:
              widget.formData[widget.formEntity.attributesEntity?.label ?? ''],
          enabled: widget.formEntity.attributesEntity?.enabled,
          required: widget.formEntity.attributesEntity?.required,
          label: widget.formEntity.attributesEntity?.label ?? '',
          items: items,
          onChanged: (value) {
            widget.onUpdate(
              widget.formEntity.attributesEntity?.label ?? '',
              value,
            );
          },
        );
      case AppStrings.switchWidget:
        return CustomSwitch(
          value:
              widget.formData[widget.formEntity.attributesEntity?.label ?? ''],
          label: widget.formEntity.attributesEntity?.label,
          enabled: widget.formEntity.attributesEntity?.enabled,
          required: widget.formEntity.attributesEntity?.required,
          onChanged: (value) {
            widget.onUpdate(
              widget.formEntity.attributesEntity?.label ?? '',
              value,
            );
          },
        );
      case AppStrings.sliderWidget:
        return CustomSlider(
          label: widget.formEntity.attributesEntity?.label,
          selectedValue:
              widget.formData[widget.formEntity.attributesEntity?.label ?? ''],
          enabled: widget.formEntity.attributesEntity?.enabled,
          min: widget.formEntity.attributesEntity?.min ?? '0',
          max: widget.formEntity.attributesEntity?.max ?? '100',
          divisions: widget.formEntity.attributesEntity?.divisions ?? '10',
          onChanged: (value) {
            widget.onUpdate(
              widget.formEntity.attributesEntity?.label ?? '',
              value,
            );
          },
        );
      case AppStrings.rangeSliderWidget:
        return CustomRangeSlider(
          label: widget.formEntity.attributesEntity?.label,
          selectedValues:
              widget.formData[widget.formEntity.attributesEntity?.label ?? ''],
          enabled: widget.formEntity.attributesEntity?.enabled,
          min: widget.formEntity.attributesEntity?.min ?? '0',
          max: widget.formEntity.attributesEntity?.max ?? '100',
          divisions: widget.formEntity.attributesEntity?.divisions ?? '10',
          onChanged: (value) {
            widget.onUpdate(
              widget.formEntity.attributesEntity?.label ?? '',
              value,
            );
          },
        );
      case AppStrings.autocompleteWidget:
        final List<String> options =
            jsonDecode(
              widget.formEntity.attributesEntity?.options ?? '[]',
            ).cast<String>();
        return CustomAutocomplete(
          label: widget.formEntity.attributesEntity?.label,
          hint: widget.formEntity.attributesEntity?.hint,
          enabled: widget.formEntity.attributesEntity?.enabled,
          required: widget.formEntity.attributesEntity?.required,
          selectedValue:
              widget.formData[widget.formEntity.attributesEntity?.label ?? ''],
          options: options,
          maxLines: widget.formEntity.attributesEntity?.maxLines,
          keyboardType: widget.formEntity.attributesEntity?.keyboardType,
          onSelected: (value) {
            widget.onUpdate(
              widget.formEntity.attributesEntity?.label ?? '',
              value,
            );
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
