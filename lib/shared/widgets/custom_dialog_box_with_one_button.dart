import 'package:flutter/material.dart';

Future<dynamic> customDialogBoxWithOneButton(
  BuildContext context,
  String message,
  IconData icon,
  Color iconColor,
  String buttonText,
  VoidCallback onPressed,
) {
  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Icon(icon, color: iconColor, size: 35),
          content: Text(
            message,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(buttonText),
              ),
            ),
          ],
        ),
  );
}
