import 'package:flutter/material.dart';

class CustomRangeSlider extends StatelessWidget {
  final String? label;
  final String? enabled;
  final String min;
  final String max;
  final String divisions;
  final RangeValues? selectedValues;
  final ValueChanged<RangeValues>? onChanged;

  const CustomRangeSlider({
    super.key,
    this.label,
    this.enabled,
    required this.min,
    required this.max,
    required this.divisions,
    this.selectedValues,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? 'Select Range',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        RangeSlider(
          values:
              selectedValues ??
              RangeValues(
                double.tryParse(min) ?? 0.0,
                double.tryParse(max) ?? 100.0,
              ),
          min: double.tryParse(min) ?? 0.0,
          max: double.tryParse(max) ?? 100.0,
          divisions: int.tryParse(divisions) ?? 10,
          labels: RangeLabels(
            '${selectedValues?.start}',
            '${selectedValues?.end}',
          ),
          onChanged: onChanged,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(min, style: Theme.of(context).textTheme.bodySmall),
              Text(max, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}
