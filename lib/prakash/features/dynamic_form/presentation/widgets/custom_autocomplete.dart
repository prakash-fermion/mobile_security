import 'package:flutter/material.dart';
import 'package:mobile_security/prakash/core/utils/utils.dart';

class CustomAutocomplete extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? required;
  final String? enabled;
  final List<String> options;
  final String? maxLines;
  final String? keyboardType;
  final String? selectedValue;
  final Function(String) onSelected;
  const CustomAutocomplete({
    super.key,
    this.label,
    this.hint,
    this.required,
    this.enabled,
    required this.options,
    this.maxLines,
    this.keyboardType,
    this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return options.where((option) {
          return option.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          );
        });
      },
      onSelected: (String selection) {
        onSelected(selection);
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController textEditingController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        textEditingController.text = selectedValue ?? '';
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
          enabled: enabled?.toLowerCase() == 'true',
          keyboardType: Utils.getKeyboardType(keyboardType),
          maxLines: int.tryParse(maxLines ?? '1'),
          validator: (value) {
            if (required?.toLowerCase() == 'true' &&
                (value == null || value.isEmpty)) {
              return '$label is required';
            }
            return null;
          },
        );
      },
    );
  }
}
