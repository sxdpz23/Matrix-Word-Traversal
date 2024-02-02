import 'dart:async';

import 'package:flutter/material.dart';
import 'package:matrix_word_traversal_test/model.dart';
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
            builder: (context) => const HomeScreen(title: "Test Puzzle")),
      );
      timer.cancel();
    });
    return Scaffold(
      backgroundColor: ConstantValues.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlutterLogo(size: MediaQuery.of(context).size.width * 0.2),
            const SizedBox(height: 50.0),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  text: "Mobigic Test\n",
                  children: <TextSpan>[
                    TextSpan(
                      text: "Puzzle: 2D Matrix Aplhabet\nPattern Search\n",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: "App Designed by ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const TextSpan(
                        text: "sxpz23",
                        style: TextStyle(
                          color: ConstantValues.accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
