import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class QuizQuestion {
  String question;
  List<String> options;
  String correctAnswer;

  QuizQuestion(this.question, this.options, this.correctAnswer);
}

class ChoiceQuizScreen extends StatefulWidget {
  const ChoiceQuizScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizeScreenState createState() => _QuizeScreenState();
}

class _QuizeScreenState extends State<ChoiceQuizScreen> {
  List<QuizQuestion> quizQuestions = [];

  @override
  void initState() {
    super.initState();
    loadQuizData();
  }

  Future<void> loadQuizData() async {
    final String quizDataString = await rootBundle.loadString('assets/data/quiz_data.csv');
    final List<List<dynamic>> csvTable = const CsvToListConverter().convert(quizDataString);

    setState(() {
      quizQuestions = csvTable.map((row) {
        return QuizQuestion(
          row[0],
          [row[1], row[2], row[3], row[4]],
          row[5],
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Text('4択クイズ'),
        ),
        backgroundColor: Colors.blue[300],
      ),
      body: quizQuestions.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : QuizWidget(quizQuestions),
    );
  }
}

class QuizWidget extends StatelessWidget {

  final List<QuizQuestion> quizQuestions;
  const QuizWidget(this.quizQuestions, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: quizQuestions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Q${index + 1}: ${quizQuestions[index].question}',
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Column(
                children: quizQuestions[index].options.map((option) {
                  return RadioListTile(
                    title: Text(option),
                    value: option,
                    groupValue: null,
                    onChanged: (value) {
                      // Handle the selected answer
                      debugPrint('Selected answer: $value');
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}