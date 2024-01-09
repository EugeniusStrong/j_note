part of 'note_list_bloc.dart';

abstract class NoteListEvent extends Equatable {
  const NoteListEvent();
}

class NoteListScreenStarted extends NoteListEvent {
  @override
  List<Object?> get props => [];
}

class SignOutPressed extends NoteListEvent {
  @override
  List<Object?> get props => [];
}

class CreatedRequested extends NoteListEvent {
  final String subtitle;
  final String title;
  final int imageIndex;

  const CreatedRequested({
    required this.subtitle,
    required this.title,
    required this.imageIndex,
  });

  @override
  List<Object?> get props => [
        subtitle,
        title,
        imageIndex,
      ];
}

class UpdateRequested extends NoteListEvent {
  final String subtitle;
  final String title;
  final int imageIndex;
  final NoteModel originalNote;

  const UpdateRequested({
    required this.subtitle,
    required this.title,
    required this.imageIndex,
    required this.originalNote,
  });

  @override
  List<Object?> get props => [
        subtitle,
        title,
        imageIndex,
        originalNote,
      ];
}

class DeleteRequested extends NoteListEvent {
  final String id;

  const DeleteRequested({required this.id});
  @override
  List<Object?> get props => [id];
}
