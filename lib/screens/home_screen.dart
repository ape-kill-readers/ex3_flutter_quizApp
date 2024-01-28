import 'package:flutter/material.dart';
import 'choice_quiz.dart';
import 'written_quiz.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Text('英単語クイズ'),
        ),
        backgroundColor: Colors.blue[300],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
              // Navigate to the second screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChoiceQuizScreen()),
                );
              },
              child: const Text('4択クイズ'),
            ),
            const SizedBox(width:  20.0),
            ElevatedButton(
              onPressed: () {
              // Navigate to the second screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WrittenQuizScreen()),
                );
              },
              child: const Text('記述クイズ'),
            ),
          ],
        ),
      ),
    );
  }
}