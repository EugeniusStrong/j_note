import 'package:flutter/material.dart';
import 'package:j_note/data/firestore/firestore.dart';
import 'package:j_note/model/note_model.dart';
import 'package:j_note/widgets/input_note_widget.dart';

class EditNote extends StatefulWidget {
  final NoteModel _note;

  const EditNote(this._note, {super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  int imageIndex = 0;
  late final TextEditingController _titleController;
  late final TextEditingController _subtitleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget._note.title);
    _subtitleController = TextEditingController(text: widget._note.subtitle);
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
      () => FirestoreDatasource().updateNote(
        widget._note.id,
        imageIndex,
        _titleController.text,
        _subtitleController.text,
      ),
      (int index) {
        setState(() {
          imageIndex = index;
        });
      },
      'EDIT',
      _titleController,
      _subtitleController,
      imageIndex,
    );
  }
}
