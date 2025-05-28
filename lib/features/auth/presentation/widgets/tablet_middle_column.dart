import 'package:flutter/material.dart';

class MiddleColumn extends StatelessWidget {
  const MiddleColumn({
    super.key,
    required this.sampleNotes,
    required this.selectedNote,
    required this.onSelect,
  });

  final List<Map<String, dynamic>> sampleNotes;
  final Map<String, dynamic>? selectedNote;
  final void Function(Map<String, dynamic>) onSelect;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sampleNotes.length,
      itemBuilder: (context, index) {
        final note = sampleNotes[index];
        return Column(
          children: [
            ListTile(
              selected: selectedNote == note,
              hoverColor: const Color.fromARGB(22, 96, 125, 139),
              splashColor: const Color.fromARGB(21, 96, 125, 139),
              isThreeLine: true,
              title: Text(note['title']),
              subtitle: Text(note['content']),
              onTap: () => onSelect(note),
            ),
            Divider(thickness: 1, height: 0),
          ],
        );
      },
    );
  }
}
