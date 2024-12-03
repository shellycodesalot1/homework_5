import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'summary_screen.dart';

class QuizScreen extends StatefulWidget {
  final int numQuestions;
  final String category;
  final String difficulty;
  final String type;

  const QuizScreen({super.key, 
    required this.numQuestions,
    required this.category,
    required this.difficulty,
    required this.type,
  });

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<dynamic> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  int timeLeft = 15;
  Timer? timer;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final url =
        'https://opentdb.com/api.php?amount=${widget.numQuestions}&category=${widget.category}&difficulty=${widget.difficulty}&type=${widget.type}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        questions = json.decode(response.body)['results'];
        isLoading = false;
        startTimer();
      });
    } else {
      throw Exception('Failed to load questions');
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
          nextQuestion();
        }
      });
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        timeLeft = 15;
        startTimer();
      });
    } else {
      timer?.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SummaryScreen(score: score, total: questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        actions: [Text('Score: $score')],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Time left: $timeLeft', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text(question['question'], style: const TextStyle(fontSize: 24)),
            ...(question['incorrect_answers'] as List<dynamic>).map((answer) {
              return ElevatedButton(
                onPressed: () {
                  if (answer == question['correct_answer']) {
                    setState(() {
                      score++;
                    });
                  }
                  nextQuestion();
                },
                child: Text(answer),
              );
            }),
          ],
        ),
      ),
    );
  }
}
