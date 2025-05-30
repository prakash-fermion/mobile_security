import 'package:flutter/material.dart';
import 'package:mobile_security/prakash/features/dynamic_form/domain/entities/dropdown_item_entity.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? required;
  final String? enabled;
  final List<DropdownItemEntity> items;
  final DropdownItemEntity? selectedValue;
  final Function(DropdownItemEntity) onChanged;
  const CustomDropdownFormField({
    super.key,
    this.label,
    this.hint,
    this.required,
    this.enabled,
    required this.items,
    this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<DropdownItemEntity>(
      value: selectedValue,

      items:
          items.map((DropdownItemEntity item) {
            return DropdownMenuItem<DropdownItemEntity>(
              value: item,
              child: Text(item.label ?? ''),
            );
          }).toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
      validator: (value) {
        if (required?.toLowerCase() == 'true' && value == null) {
          return '$label is required';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }
}
