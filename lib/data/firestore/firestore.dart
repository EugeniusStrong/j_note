import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:j_note/model/note_model.dart';
import 'package:uuid/uuid.dart';

class FirestoreDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Result> createUser(String email) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({"id": _auth.currentUser!.uid, "email": email});
      return Result.value(true);
    } catch (e) {
      debugPrint(e.toString());
      return Result.error(e);
    }
  }

  Future<Result> addNote(String subtitle, String title, int image) async {
    try {
      var uuid = const Uuid().v4();
      DateTime data = DateTime.now();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .set({
        'id': uuid,
        'title': title,
        'subtitle': subtitle,
        'time': '${data.hour}:${data.minute}',
        'image': image,
        'isDone': false,
      });
      return Result.value(true);
    } catch (e) {
      debugPrint(e.toString());
      return Result.error(e);
    }
  }

  Result<List<NoteModel>> getNotes(AsyncSnapshot<QuerySnapshot> snapshot) {
    try {
      final notesList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        String time = data['time'] is Timestamp
            ? (data['time'] as Timestamp).toDate().toString()
            : data['time'] as String;

        bool isDone = data['isDone'] != null && data['isDone'] is bool
            ? data['isDone'] as bool
            : false;

        return NoteModel(
          data['id'],
          data['title'],
          data['subtitle'],
          time,
          data['image'],
          isDone,
        );
      }).toList();
      return Result.value(notesList);
    } catch (e) {
      debugPrint(e.toString());
      return Result.error(e);
    }
  }

  Stream<QuerySnapshot> stream() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('notes')
        .snapshots();
  }

  Future<Result> isDone(String uuid, bool isDone) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({'isDone': isDone});
      return Result.value(true);
    } catch (e) {
      debugPrint(e.toString());
      return Result.error(e);
    }
  }

  Future<Result> updateNote(
      String id, int image, String title, String subtitle) async {
    try {
      DateTime data = DateTime.now();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(id)
          .update({
        'time': '${data.hour}:${data.minute}',
        'subtitle': subtitle,
        'title': title,
        'image': image,
      });
      return Result.value(true);
    } catch (e) {
      debugPrint(e.toString());
      return Result.error(e);
    }
  }

  Future<Result> deleteNote(String id) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(id)
          .delete();
      return Result.value(true);
    } catch (e) {
      debugPrint(e.toString());
      return Result.error(e);
    }
  }
}
