import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:j_note/data/firestore/firestore.dart';

abstract class AuthenticationData {
  Future<void> register(String email, String password, String confirmPassword);

  Future<void> login(String email, String password);

  Future<void> signOut();

  Future passwordReset(String email, BuildContext context);
}

class AuthenticationRemote extends AuthenticationData {
  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> register(
      String email, String password, String confirmPassword) async {
    if (confirmPassword == password) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        FirestoreDatasource().createUser(email);
      });
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Ошибка при выходе из учетной записи: $e");
    }
  }

  @override
  Future passwordReset(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('Password reset link sent to $email! Check your email'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            e.message.toString(),
          ),
        ),
      );
    }
  }
}
