import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mobile_security/prakash/core/utils/custom_logger.dart';
import 'package:mobile_security/prakash/core/utils/utils.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? inputType;
  final String? label;
  final String? hint;
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
  final String? regex;
  final Function(String) onChanged;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.initialValue,
    this.inputType,
    this.label,
    this.hint,
    this.required,
    this.enabled,
    this.maxLength,
    this.keyboardType,
    this.obscureText,
    this.maxLines,
    this.useDatePicker,
    this.dateFormat,
    this.useTimePicker,
    this.timeFormat,
    this.regex,
    required this.onChanged,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = false;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((date) {
      if (date != null) {
        DateFormat dateFormat = DateFormat(widget.dateFormat ?? 'yyyy-MM-dd');
        String formattedDate = dateFormat.format(date);
        widget.controller?.text = formattedDate;
        widget.onChanged(formattedDate);
        CustomLogger.info('Selected date: $formattedDate');
      }
    });
  }

  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now()).then((time) {
      if (time != null) {
        DateFormat timeFormat = DateFormat(widget.timeFormat ?? 'HH:mm');
        // Convert TimeOfDay to DateTime for formatting
        DateTime now = DateTime.now();
        DateTime dateTime = DateTime(
          now.year,
          now.month,
          now.day,
          time.hour,
          time.minute,
        );
        // Format the time using the specified format
        String formattedTime = timeFormat.format(dateTime);
        widget.controller?.text = formattedTime;
        widget.onChanged(formattedTime);
        CustomLogger.info('Selected time: $formattedTime');
      }
    });
  }

  @override
  void initState() {
    if (widget.obscureText?.toLowerCase() == 'true') {
      obscureText = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      enabled: widget.enabled?.toLowerCase() == 'true',
      obscureText: obscureText,
      obscuringCharacter: '*',
      maxLines: widget.maxLines != null ? int.tryParse(widget.maxLines!) : 1,
      readOnly:
          widget.useDatePicker?.toLowerCase() == 'true' ||
          widget.useTimePicker?.toLowerCase() == 'true',
      onTap: () {
        if (widget.useDatePicker?.toLowerCase() == 'true') {
          _showDatePicker();
        } else if (widget.useTimePicker?.toLowerCase() == 'true') {
          _showTimePicker();
        }
      },
      inputFormatters:
          widget.inputType?.toLowerCase() == 'number' || widget.inputType?.toLowerCase() == 'phone'
              ? [FilteringTextInputFormatter.digitsOnly]
              : [
                FilteringTextInputFormatter.allow(
                   RegExp(r'.*'),
                  // (widget.regex != null && widget.regex!.isNotEmpty) ? RegExp(r'${widget.regex}') : RegExp(r'.*'),
                ),
              ],
      maxLength:
          widget.maxLength != null ? int.tryParse(widget.maxLength!) : null,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        enabled: widget.enabled?.toLowerCase() == 'true',
        border: OutlineInputBorder(),
        counterText: '',
        suffixIcon:
            widget.obscureText?.toLowerCase() == 'true'
                ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                )
                : null,
      ),
      keyboardType: Utils.getKeyboardType(widget.keyboardType),
      textInputAction: TextInputAction.done,
      onChanged: widget.onChanged,
      validator: (value) {
        if (widget.required?.toLowerCase() == 'true' &&
            (value == null || value.isEmpty)) {
          return '${widget.label} is required';
        }
        if (widget.regex != null && widget.regex!.isNotEmpty ) {
          final regex = RegExp(widget.regex!);
          if (value != null && !regex.hasMatch(value)) {
            return 'Invalid format for ${widget.label}';
          }
        }
        return null;
      },
    );
  }
}
