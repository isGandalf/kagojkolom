import 'package:flutter/material.dart';

void customSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 1),
      backgroundColor: color,
      content: Text(message, style: TextStyle(color: Colors.white)),
    ),
  );
}
