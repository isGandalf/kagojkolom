import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final double iconSize;
  const FloatingButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: FloatingActionButton(
        elevation: 5,
        shape: const CircleBorder(),
        onPressed: onTap,
        child: Icon(icon, size: iconSize),
      ),
    );
  }
}
