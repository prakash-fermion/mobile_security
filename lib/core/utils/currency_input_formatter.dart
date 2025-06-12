import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Custom TextInputFormatter to format numbers with comma separators.
class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If the new value is empty, return empty
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Remove all non-digit characters from the new value
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // If the cleaned text is empty, return empty
    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Parse the cleaned text to an integer
    int value = int.parse(newText);

    // Format the number with commas using NumberFormat
    // You can customize the locale if needed, e.g., NumberFormat('#,##0.00', 'en_US')
    // For Indian currency, it's typically '#,##,##0'
    final formatter = NumberFormat('#,##0', 'en_US'); // Using en_US for standard comma separation (e.g., 1,000,000)
    // If you need Indian Lakh/Crore format (e.g., 10,00,000), you'd need a more specific formatter or custom logic.
    // For simplicity and common use, the standard comma format is used here.

    String formattedText = formatter.format(value);

    // Calculate the new cursor position
    TextSelection newSelection = newValue.selection;
    int oldLength = oldValue.text.length;
    int newLength = formattedText.length;

    // Adjust cursor position based on added/removed commas
    if (newLength > oldLength) {
      // If text length increased (commas added), move cursor forward by the difference
      newSelection = newValue.selection.copyWith(
        baseOffset: newSelection.baseOffset + (newLength - oldLength),
        extentOffset: newSelection.extentOffset + (newLength - oldLength),
      );
    } else if (newLength < oldLength) {
      // If text length decreased (commas removed), move cursor backward by the difference
      newSelection = newValue.selection.copyWith(
        baseOffset: newSelection.baseOffset - (oldLength - newLength),
        extentOffset: newSelection.extentOffset - (oldLength - newLength),
      );
    }

    // Ensure the cursor doesn't go out of bounds
    if (newSelection.baseOffset > formattedText.length) {
      newSelection = TextSelection.collapsed(offset: formattedText.length);
    }

    return newValue.copyWith(
      text: formattedText,
      selection: newSelection,
    );
  }
}
