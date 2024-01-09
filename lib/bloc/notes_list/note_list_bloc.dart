import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:j_note/data/auth_data/auth_data.dart';
import 'package:j_note/data/firestore/firestore.dart';
import 'package:j_note/model/note_model.dart';

part 'note_list_event.dart';
part 'note_list_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final AuthenticationRemote authenticationRemote;
  final FirestoreDatasource firestoreDatasource;
  final AsyncSnapshot<QuerySnapshot> snapshot;

  NoteListBloc(
    this.authenticationRemote,
    this.firestoreDatasource,
    this.snapshot,
  ) : super(NoteListInitial()) {
    on<SignOutPressed>((event, emit) async {
      final result = await authenticationRemote.signOut();
      if (result.isValue) {
        emit(NoteListExit());
      } else {
        emit(NoteListError(error: result.asError!.error));
      }
    });

    on<NoteListScreenStarted>((event, emit) {
      final notesList = firestoreDatasource.getNotes(snapshot);
      if (notesList.isValue) {
        emit(NoteListLoadSuccess(notesList: notesList.asValue!.value));
      } else {
        emit(NoteListError(error: notesList.asError!.error));
      }
    });
    on<CreatedRequested>((event, emit) async {
      await firestoreDatasource.addNote(
          event.subtitle, event.title, event.imageIndex);
      final notesList = firestoreDatasource.getNotes(snapshot);
      if (notesList.isValue) {
        emit(NoteListLoadSuccess(notesList: notesList.asValue!.value));
      } else {
        emit(NoteListError(error: notesList.asError!.error));
      }
    });
    on<UpdateRequested>((event, emit) async {
      await firestoreDatasource.updateNote(
          event.originalNote.id, event.imageIndex, event.title, event.subtitle);
      final notesList = firestoreDatasource.getNotes(snapshot);
      if (notesList.isValue) {
        emit(NoteListLoadSuccess(notesList: notesList.asValue!.value));
      } else {
        emit(NoteListError(error: notesList.asError!.error));
      }
    });
    on<DeleteRequested>((event, emit) async {
      await firestoreDatasource.deleteNote(event.id);
      final notesList = firestoreDatasource.getNotes(snapshot);
      if (notesList.isValue) {
        emit(NoteListLoadSuccess(notesList: notesList.asValue!.value));
      } else {
        emit(NoteListError(error: notesList.asError!.error));
      }
    });
  }
}
