import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:j_note/auth_screens/login_screen.dart';
import 'package:j_note/bloc/forgot_pass/forgot_password_bloc.dart';
import 'package:j_note/data/auth_data/auth_data.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  late final TextEditingController _emailController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(
            () {},
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _emailController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(AuthenticationRemote()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reset Password Form'),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[300],
        body: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          builder: (context, state) {
            if (state is ForgotPasswordInitial) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    const FaIcon(
                      FontAwesomeIcons.key,
                      color: Colors.deepPurple,
                      size: 150,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        'Enter Your Email and we will send you a password reset link',
                        style: GoogleFonts.bebasNeue(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: 'Email'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Reset Password',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        onTap: () {
                          context.read<ForgotPasswordBloc>().add(
                                PressResetButton(
                                  email: _emailController.text.trim(),
                                  context: context,
                                ),
                              );
                          _startTimer();
                          _emailController.clear();
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
