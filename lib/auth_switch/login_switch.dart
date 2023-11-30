import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:j_note/auth_switch/auth_switch.dart';
import 'package:j_note/note_screens/note_list_screen.dart';

class LoginSwitch extends StatelessWidget {
  const LoginSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const NoteListScreen();
          } else {
            return const AuthSwitch();
          }
        },
      ),
    );
  }
}
