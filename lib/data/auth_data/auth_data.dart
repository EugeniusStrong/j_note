import 'dart:async';
import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:j_note/data/firestore/firestore.dart';

abstract class AuthenticationData {
  Future<Result> register(String email, String password);

  Future<Result> login(String email, String password);

  Future<Result> signOut();

  Future<Result> passwordReset(String email);
}

class AuthenticationRemote extends AuthenticationData {
  @override
  Future<Result<UserCredential>> login(String email, String password) async {
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Result.value(result);
    } catch (e) {
      debugPrint("Ошибка при входе: $e");
      return Result.error(e);
    }
  }

  @override
  Future<Result<UserCredential>> register(String email, String password) async {
    try {
      final user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirestoreDatasource().createUser(email);
      return Result.value(user);
    } catch (e) {
      debugPrint("Ошибка при регистрации: $e");
      return Result.error(e);
    }
  }

  @override
  Future<Result> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return Result.value(true);
    } catch (e) {
      debugPrint("Ошибка при выходе из учетной записи: $e");
      return Result.error(e);
    }
  }

  @override
  Future<Result> passwordReset(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return Result.value(true);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return Result.error(e);
    }
  }
}
