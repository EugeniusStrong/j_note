import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:j_note/bloc/app/app_bloc.dart';
import 'package:j_note/screens/auth_screens/auth_screen.dart';
import 'package:j_note/screens/note_screens/note_list_screen.dart';

class AuthSwitch extends StatelessWidget {
  const AuthSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc()..add(AppStarted()),
      child: BlocListener<AppBloc, AppState>(
        listener: (BuildContext context, state) {
          if (state is GoToLoginScreen) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AuthScreen()));
          } else if (state is GoToListNoteListScreen) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NoteListScreen(nameUser: state.email)));
          }
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
