import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final String? label;
  final bool tristate;
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  const CustomCheckbox({
    super.key,
    this.label,
    this.tristate = false,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (tristate == true) {
          if (value == null) {
            onChanged?.call(true);
          } else if (value == true) {
            onChanged?.call(false);
          } else {
            onChanged?.call(null);
          }
        } else {
          onChanged?.call(value == true ? false : true);
        }
      },
      child: Row(
        children: [
          Checkbox(
            tristate: tristate,
            value: tristate ? value : value == true,
            onChanged: onChanged,
          ),
          const SizedBox(width: 8),
          Text(
            label ?? '',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
