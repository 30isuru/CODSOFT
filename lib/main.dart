import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'pages/plash.dart';
// Import your ToDo class file

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      nextScreen: Plash(), // Change to ToDoListScreen
      splashTransition: SplashTransition.fadeTransition,
      duration: 3000,
    );
  }
}
