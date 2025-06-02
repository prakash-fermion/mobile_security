import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  const Utils._();

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

  static String formatIndianCurrency(int amount) {
    final indianRupeesFormat = NumberFormat.currency(
      name: "INR",
      locale: 'en_IN',
      decimalDigits: 0,
      symbol: '₹ ',
    );
    return indianRupeesFormat.format(amount);
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
