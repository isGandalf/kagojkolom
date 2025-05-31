import 'package:flutter/material.dart';

class AddNoteContentTextFeild extends StatelessWidget {
  const AddNoteContentTextFeild({
    super.key,
    required TextEditingController noteContentController,
  }) : _noteContentController = noteContentController;

  final TextEditingController _noteContentController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: _noteContentController,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(hintText: 'Content'),
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
      ),
    );
  }
}
