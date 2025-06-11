import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;

  const ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Text(message, style: const TextStyle(fontSize: 16)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}

// Usage Example:
// To display the dialog, use the following code in your screen:
// showDialog(
//   context: context,
//   builder: (context) => ErrorDialog(message: 'An unexpected error occurred.'),
// );
