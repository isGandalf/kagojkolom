import 'package:flutter/material.dart';

class DeleteAllNotes extends StatelessWidget {
  const DeleteAllNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'This will delete all notes forever and cannot be retrieved. Please choose your action carefully.',
            overflow: TextOverflow.clip,
          ),
        ),
        SizedBox(width: 20),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.red.shade900),
            ),
            child: Text(
              'Delete all notes',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
