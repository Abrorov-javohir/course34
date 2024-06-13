class Note {
  int id;
  String title;
  String content;

  Note({
    required this.id,
    required this.title,
    required this.content,
  });
}

List<Note> notes = [
  Note(id: 1, title: 'Note 1', content: 'Content 1'),
  Note(id: 2, title: 'Note 2', content: 'Content 2'),
];

void updateNote(int id, String title, String content) {
  for (var note in notes) {
    if (note.id == id) {
      note.title = title;
      note.content = content;
      break;
    }
  }
}
