part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class AppInitial extends AppState {
  @override
  List<Object> get props => [];
}

class GoToLoginScreen extends AppState {
  @override
  List<Object> get props => [];
}

class GoToListNoteListScreen extends AppState {
  final String email;

  const GoToListNoteListScreen({required this.email});
  @override
  List<Object> get props => [email];
}
