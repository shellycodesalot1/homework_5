import 'package:flutter/material.dart';
import 'setup_screen.dart';

class SummaryScreen extends StatelessWidget {
  final int score;
  final int total;

  const SummaryScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your Score: $score/$total', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SetupScreen()),
                  (route) => false,
                );
              },
              child: const Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
