import 'dart:async';

import 'package:flutter/material.dart';
import 'package:matrix_word_traversal_test/screens/home.dart';

/// Splash Screen for the aApplication
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, required this.duration});

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    //Setting timer for next page
    Timer.periodic(duration, (timer) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const MyHomePage(title: "Test Puzzle")),
      );
      timer.cancel();
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FlutterLogo(size: MediaQuery.of(context).size.width * 0.2),
      ),
    );
  }
}
