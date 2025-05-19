import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: FloatingActionButton(
        elevation: 5,
        shape: const CircleBorder(),
        onPressed: () {},
        child: Icon(Icons.add, size: 50),
      ),
    );
  }
}
