import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:j_note/data/firestore/firestore.dart';
import 'package:j_note/model/note_model.dart';
import 'package:j_note/screens/note_screens/edit_note.dart';
import 'package:j_note/widgets/image_for_card.dart';

class TaskWidget extends StatefulWidget {
  final NoteModel _note;

  const TaskWidget(this._note, {super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDone = widget._note.isDone;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            imageForCard(
              'assets/images_actions/${widget._note.image}.jpg',
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget._note.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration:
                                  isDone ? TextDecoration.lineThrough : null,
                              color: isDone ? Colors.grey : Colors.black,
                            ),
                          ),
                        ),
                        Checkbox(
                          fillColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return Colors.green;
                              }
                              return null;
                            },
                          ),
                          value: isDone,
                          onChanged: (value) {
                            setState(
                              () {
                                isDone = !isDone;
                              },
                            );
                            FirestoreDatasource()
                                .isDone(widget._note.id, isDone);
                          },
                        ),
                      ],
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      widget._note.subtitle,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 90,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Colors.green[600],
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.clock,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                Flexible(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    widget._note.time,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditNote(widget._note),
                              ),
                            );
                          },
                          child: Container(
                            width: 90,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.penToSquare,
                                  size: 15,
                                ),
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
