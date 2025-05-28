import 'package:flutter/material.dart';

class TabletDrawerIcon extends StatelessWidget {
  const TabletDrawerIcon({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: IconButton(onPressed: onPressed, icon: Icon(icon)),
    );
  }
}
