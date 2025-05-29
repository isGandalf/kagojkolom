abstract class NotesErrors {
  String get message;

  @override
  String toString() {
    return message;
  }
}

class FetchNotesError implements NotesErrors {
  @override
  final String message;

  FetchNotesError({required this.message});
}

class AddNoteError implements NotesErrors {
  @override
  final String message;

  AddNoteError({required this.message});
}

class UpdateNoteError implements NotesErrors {
  @override
  final String message;

  UpdateNoteError({required this.message});
}

class DeleteNoteError implements NotesErrors {
  @override
  final String message;

  DeleteNoteError({required this.message});
}
