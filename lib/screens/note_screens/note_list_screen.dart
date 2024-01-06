import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:j_note/data/auth_data/auth_data.dart';
import 'package:j_note/data/firestore/firestore.dart';
import 'package:j_note/screens/auth_screens/auth_screen.dart';
import 'package:j_note/screens/note_screens/add_note.dart';
import 'package:j_note/widgets/task_widget.dart';

class NoteListScreen extends StatefulWidget {
  final String nameUser;

  const NoteListScreen({super.key, required this.nameUser});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

bool show = true;

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nameUser),
        actions: [
          IconButton(
            onPressed: () {
              AuthenticationRemote().signOut();

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()));
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddNote()));
          },
          backgroundColor: Colors.deepPurple,
          child: const FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: StreamBuilder<QuerySnapshot>(
            stream: FirestoreDatasource().stream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final listNotes = FirestoreDatasource().getNotes(snapshot);
              if (listNotes.isEmpty) {
                return const Center(
                  child: Text(
                    "Create a note by pressing ' + '",
                    style: TextStyle(fontSize: 25.0, color: Colors.black38),
                  ),
                );
              }

              return ListView.builder(
                itemCount: listNotes.length,
                itemBuilder: (context, index) {
                  final note = listNotes[index];
                  return Dismissible(
                      onDismissed: (direction) {
                        FirestoreDatasource().deleteNote(note.id);
                      },
                      key: UniqueKey(),
                      child: TaskWidget(note));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
