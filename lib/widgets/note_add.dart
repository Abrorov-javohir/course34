
import 'package:course/screens/update_note.dart';
import 'package:flutter/material.dart';


void _showEditNoteDialog(BuildContext context, note) {
  String title = note.title;
  String content = note.content;

  TextEditingController titleController = TextEditingController(text: title);
  TextEditingController contentController = TextEditingController(text: content);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onChanged: (value) {
                title = value;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Content'),
              controller: contentController,
              onChanged: (value) {
                content = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (title.isNotEmpty && content.isNotEmpty) {
                updateNote(note.id, title, content);
                Navigator.of(context).pop();
              }
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}

