import 'package:flutter/material.dart';

class AddNoteTitleTextFeild extends StatelessWidget {
  const AddNoteTitleTextFeild({
    super.key,
    required TextEditingController noteTitleController,
  }) : _noteTitleController = noteTitleController;

  final TextEditingController _noteTitleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontSize: 25),
      controller: _noteTitleController,
      decoration: InputDecoration(hintText: 'Title'),
    );
  }
}
