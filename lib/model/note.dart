class Note {
  int id;
  String title;
  String content;
  DateTime createdDate;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdDate': createdDate.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      createdDate: DateTime.parse(map['createdDate']),
    );
  }
}
