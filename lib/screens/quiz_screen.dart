import 'package:flutter/material.dart';


class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        backgroundColor: Colors.orange[300],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Navigate back to the first screen
            Navigator.pop(context);
          },
          child: const Text('Go back to First Screen'),
        ),
      ),
    );
  }
}