import 'package:flutter/material.dart';
import 'setup_screen.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Customizable Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SetupScreen(),
    );
  }
}
