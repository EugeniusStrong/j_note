part of 'note_list_bloc.dart';

abstract class NoteListState extends Equatable {
  const NoteListState();
}

class NoteListInitial extends NoteListState {
  @override
  List<Object> get props => [];
}

class NoteListExit extends NoteListState {
  @override
  List<Object?> get props => [];
}

class NoteListError extends NoteListState {
  final Object error;

  const NoteListError({required this.error});

  @override
  List<Object?> get props => [error];
}

class NoteListLoadSuccess extends NoteListState {
  final List<NoteModel> notesList;

  const NoteListLoadSuccess({required this.notesList});
  @override
  List<Object?> get props => [notesList];
}
