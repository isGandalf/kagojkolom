import 'package:flutter/material.dart';

class PopUpOptions extends StatelessWidget {
  final VoidCallback onTap;
  final String optionName;
  const PopUpOptions({
    super.key,
    required this.onTap,
    required this.optionName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(),
        ),
        onPressed: onTap,
        child: Text(
          optionName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
