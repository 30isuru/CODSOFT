import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:todo_app/pages/home.dart';
import 'package:todo_app/pages/plash.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "todo app",
      home: AnimatedSplash(),
    );
  }
}

class AnimatedSplash extends StatelessWidget {
  const AnimatedSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.greenAccent,
      splash: Image.asset("assets/00.png"),
      nextScreen: const Plash(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 3000,
    );
  }
}
