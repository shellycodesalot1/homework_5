import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int numQuestions = 5;
  String category = "9"; // General Knowledge default ID
  String difficulty = "easy";
  String type = "multiple";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Setup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<int>(
              value: numQuestions,
              decoration: const InputDecoration(labelText: 'Number of Questions'),
              items: [5, 10, 15]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.toString())))
                  .toList(),
              onChanged: (value) => setState(() => numQuestions = value!),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: difficulty,
              decoration: const InputDecoration(labelText: 'Difficulty'),
              items: ['easy', 'medium', 'hard']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.capitalize())))
                  .toList(),
              onChanged: (value) => setState(() => difficulty = value!),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: type,
              decoration: const InputDecoration(labelText: 'Question Type'),
              items: ['multiple', 'boolean']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.capitalize())))
                  .toList(),
              onChanged: (value) => setState(() => type = value!),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(
                      numQuestions: numQuestions,
                      category: category,
                      difficulty: difficulty,
                      type: type,
                    ),
                  ),
                );
              },
              child: const Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}
