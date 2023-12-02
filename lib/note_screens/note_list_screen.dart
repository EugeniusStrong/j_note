import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:j_note/widgets/task_widget.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

bool show = true;

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () {},
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
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const TaskWidget();
            },
          ),
        ),
      ),
    );
  }
}
