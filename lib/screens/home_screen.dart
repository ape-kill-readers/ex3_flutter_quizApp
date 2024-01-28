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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                // Navigate to the second screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChoiceQuizScreen()),
                  );
                },
                child: SizedBox(
                  child: Center(child: const Text('4択クイズ', style: TextStyle(fontSize: 20),)),
                  width: 150, height: 50
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                // Navigate to the second screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WrittenQuizScreen()),
                  );
                },
                child: SizedBox(
                  child: Center(child: const Text('記述クイズ', style: TextStyle(fontSize: 20),)),
                  width: 150, height: 50
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}