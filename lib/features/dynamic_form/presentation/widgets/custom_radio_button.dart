import 'package:flutter/material.dart';
import 'package:mobile_security/features/dynamic_form/domain/entities/dropdown_item_entity.dart';

class CustomRadioButton extends StatelessWidget {
  final String label;
  final List<DropdownItemEntity> items;
  final DropdownItemEntity? selectedValue;
  final Function(DropdownItemEntity) onChanged;
  final String? enabled;
  final String? required;

  const CustomRadioButton({
    super.key,
    required this.label,
    required this.items,
    this.selectedValue,
    required this.onChanged,
    this.enabled,
    this.required,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        ...items.map((item) {
          return RadioListTile<DropdownItemEntity>(
            title: Text(item.label ?? ''),
            value: item,
            groupValue: selectedValue,
            onChanged:
                enabled?.toLowerCase() == 'true'
                    ? (value) {
                      if (value != null) {
                        onChanged(value);
                      }
                    }
                    : null,
          );
        }),
      ],
    );
  }
}
