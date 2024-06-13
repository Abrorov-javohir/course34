import 'package:course/model/task.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatefulWidget {
  final Contact contact;
  final Function() onDelete;
  final Function() onEdit;

  const ContactItem({
    super.key,
    required this.contact,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ContactItemState createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  bool isTicked = false;

  // ignore: non_constant_identifier_names
  void CheckTick() {
    setState(() {
      isTicked = !isTicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.contact.name),
      
      subtitle: Text(widget.contact.task),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              widget.onEdit();
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.blue,
            ),
          ),
          IconButton(
            onPressed: CheckTick,
            icon: Icon(
              isTicked ? Icons.check_box : Icons.check_box_outline_blank,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              widget.onDelete();
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}