import 'package:flutter/material.dart';
import 'package:j_note/auth_screens/login_screen.dart';
import 'package:j_note/auth_screens/register_screen.dart';

class AuthSwitch extends StatefulWidget {
  const AuthSwitch({super.key});

  @override
  State<AuthSwitch> createState() => _AuthSwitchState();
}

class _AuthSwitchState extends State<AuthSwitch> {
  bool isLogin = true;

  void _loginChecker() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginScreen(_loginChecker);
    } else {
      return RegisterScreen(_loginChecker);
    }
  }
}
