import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final String? label;
  final String? enabled;
  final String min;
  final String max;
  final String divisions;
  final double? selectedValue;
  final ValueChanged<double>? onChanged;

  const CustomSlider({
    super.key,
    this.label,
    this.enabled,
    required this.min,
    required this.max,
    required this.divisions,
    this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label ?? '', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        Slider(
          value: selectedValue ?? double.tryParse(min) ?? 0.0,
          min: double.tryParse(min) ?? 0.0,
          max: double.tryParse(max) ?? 100.0,
          divisions: int.tryParse(divisions),
          label: '${selectedValue ?? min}',
          onChanged: onChanged,
        ),
      ],
    );
  }
}
