import 'package:flutter/material.dart';

class Utils {
  static String formatAmount(double amount, {int decimalPlaces = 0}) {
    // Format the number with the specified decimal places
    String formattedAmount = amount.toStringAsFixed(decimalPlaces);

    // Use a regular expression to add commas to the formatted amount
    RegExp regExp = RegExp(r"(\d)(?=(\d{3})+(?!\d))");
    formattedAmount = formattedAmount.replaceAllMapped(
      regExp,
      (match) => "${match[1]},",
    );

    return "₹$formattedAmount"; // Add ₹ symbol for currency
  }

    static void showErrorSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showSuccessSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }


  static void showSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  static TextInputType getKeyboardType(String? keyboardType) {
    switch (keyboardType?.toLowerCase()) {
      case 'visiblePassword':
        return TextInputType.visiblePassword;
      case 'emailAddress':
        return TextInputType.emailAddress;
      case 'number':
        return TextInputType.number;
      case 'phone':
        return TextInputType.phone;
      case 'url':
        return TextInputType.url;
      case 'multiline':
        return TextInputType.multiline;
      case 'datetime':
        return TextInputType.datetime;
      case 'name':
        return TextInputType.name;
      case 'streetAddress':
        return TextInputType.streetAddress;
      case 'webSearch':
        return TextInputType.webSearch;
      case 'twitter':
        return TextInputType.twitter;
      default:
        return TextInputType.text;
    }
  }
}
