abstract class NotesErrors {
  String get message;

  @override
  String toString() {
    return message;
  }
}

class FetchLocalNotesError implements NotesErrors {
  @override
  final String message;

  FetchLocalNotesError({required this.message});
}

class AddNoteToLocalError implements NotesErrors {
  @override
  final String message;

  AddNoteToLocalError({required this.message});
}

class UpdateNoteToLocalError implements NotesErrors {
  @override
  final String message;

  UpdateNoteToLocalError({required this.message});
}

class DeleteNoteFromLocalError implements NotesErrors {
  @override
  final String message;

  DeleteNoteFromLocalError({required this.message});
}
