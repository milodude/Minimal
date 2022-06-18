import 'dart:ui';

import 'package:coda_test/features/login/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passEnabled = true;
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isKeyBoardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
            body: SafeArea(
          child:SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
              top: -50,
              left: MediaQuery.of(context).size.width - 190,
              child: Container(
                width: 300,
                height: 309,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(228, 243, 83, 1)),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height / 2,
              left: -40,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(228, 243, 83, 0.33)),
              )),
          Positioned(
              top: 600,
              left: 20,
              child: Container(
                width: MediaQuery.of(context).size.width - 90,
                height: 305,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(228, 243, 83, 0.33)),
              )),
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Colors.transparent,
            ),
          )),
          Visibility(
            visible: !isKeyBoardOpen,
            child: Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: PlayAnimation<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 1),
                    builder: (context, child, value) {
                      return Opacity(
                        opacity: value,
                        child: const Text(
                          'minimal',
                          style: TextStyle(
                              fontSize: 54, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: !isKeyBoardOpen,
            child: Positioned.fill(
              top: MediaQuery.of(context).size.height - 398,
              child: Align(
                alignment: Alignment.topCenter,
                child: PlayAnimation<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(seconds: 3),
                  builder: (context, child, value) {
                    return Opacity(
                      opacity: value,
                      child: Text(
                        'LOG IN',
                        style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: !isKeyBoardOpen
                ? MediaQuery.of(context).size.height - 320
                : MediaQuery.of(context).size.height - 320 - keyboardHeight,
            child: Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 295,
                  height: 100,
                  child: TextField(
                    controller: emailInputController,
                    decoration: const InputDecoration(
                      labelText: 'Mail',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: !isKeyBoardOpen
                ? MediaQuery.of(context).size.height - 260
                : MediaQuery.of(context).size.height - 260 - keyboardHeight,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 50.0,
                  right: 50,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 295,
                  height: 100,
                  child: TextField(
                    controller: passwordInputController,
                    obscureText: passEnabled,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                passEnabled = passEnabled ? false : true;
                              });
                            },
                            icon: Icon(passEnabled == true
                                ? Icons.remove_red_eye
                                : Icons.password))),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: !isKeyBoardOpen
                ? MediaQuery.of(context).size.height - 120
                : MediaQuery.of(context).size.height - 120 - keyboardHeight,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 50.0,
                  right: 50,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Align(
                alignment: Alignment.topCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    fixedSize: const Size(296, 52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    _login(context);
                  },
                  child: const Text(
                    'LOG IN',
                    style: TextStyle(letterSpacing: 0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),),);
  }

  void _login(BuildContext context) {
    ReadContext(context).read<UserBloc>().add(LoginEvent(
          userName: emailInputController.text,
          password: passwordInputController.text,
        ));
  }
}