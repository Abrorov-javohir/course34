import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactAddDialog extends StatefulWidget {
  const ContactAddDialog({super.key});

  @override
  _ContactAddDialogState createState() => _ContactAddDialogState();
}

class _ContactAddDialogState extends State<ContactAddDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _taskController,
            decoration: InputDecoration(labelText: 'Task'),
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
            Navigator.of(context).pop({
              'name': _nameController.text,
              'task': _taskController.text,
            });
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
