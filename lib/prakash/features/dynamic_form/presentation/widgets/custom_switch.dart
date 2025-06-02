import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final String? label;
  final String? enabled;
  final String? required;
  final bool value;
  final ValueChanged<bool>? onChanged;
  const CustomSwitch({
    super.key,
    this.label,
    this.enabled,
    this.required,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label ?? '', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(width: 8),
        Switch(
          value: value,
          onChanged: enabled?.toLowerCase() == 'true' ? onChanged : null,
        ),
      ],
    );
  }
}
