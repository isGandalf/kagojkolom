import 'package:flutter/material.dart';

class ButtonForNewNote extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;
  const ButtonForNewNote({
    super.key,
    required this.buttonName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTap, child: Text(buttonName));
  }
}
