import 'package:flutter/material.dart';

MySnackBar({
  required String message,
  required BuildContext context,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color ?? Colors.red,
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
