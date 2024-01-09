import 'package:flutter/material.dart';
import 'package:j_note/data/firestore/firestore.dart';
import 'package:j_note/widgets/input_note_widget.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  int imageIndex = 0;
  late final TextEditingController _titleController;
  late final TextEditingController _subtitleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _subtitleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.clear();
    _subtitleController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return inputNote(
      context,
      () => FirestoreDatasource().addNote(
        _titleController.text,
        _subtitleController.text,
        imageIndex,
      ),
      (int index) {
        setState(() {
          imageIndex = index;
        });
      },
      'ADD',
      _subtitleController,
      _titleController,
      imageIndex,
    );
  }
}
