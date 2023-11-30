import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationData {
  Future<void> register(String email, String password, String confirmPassword);
  Future<void> login(String email, String password);
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
          .createUserWithEmailAndPassword(email: email, password: password);
    }
  }
}
