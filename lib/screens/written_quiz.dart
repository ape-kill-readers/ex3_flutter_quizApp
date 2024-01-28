import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'finish_screen.dart';

class QuizQuestion {
  String question;
  List<String> options;
  String correctAnswer;

  QuizQuestion(this.question, this.options, this.correctAnswer);
}

class WrittenQuizScreen extends StatefulWidget {
  const WrittenQuizScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizeScreenState createState() => _QuizeScreenState();
}

class _QuizeScreenState extends State<WrittenQuizScreen> {
  List<QuizQuestion> quizQuestions = [];
  int index = 0;
  int result = 0;
  Widget _judgeSign = const Text('');

  @override
  void initState() {
    super.initState();
    loadQuizData();
  }

  void nextQuestion() {
    setState(() {
      if (index >= quizQuestions.length - 2) {
        index = 0;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FinishScreen(score: result, maxScore: (quizQuestions.length - 1))),
        );
      } else {
        index += 1;
      }
    });
  }

  Future<void> judgeAnswer(bool isCorrect) async {
    setState(() {
      if (isCorrect){
        _judgeSign = Text('○',
            style: TextStyle(fontSize: 300.0, color: Colors.green.shade400));
        result += 1;
      } else {
        _judgeSign = Text('×',
            style: TextStyle(fontSize: 300.0, color: Colors.red.shade400));
      }      
    });
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _judgeSign = const Text('');
      nextQuestion();
    });
  }

  Future<void> loadQuizData() async {
    final String quizDataString =
        await rootBundle.loadString('assets/data/quiz_data.csv');
    final List<List<dynamic>> csvTable =
        const CsvToListConverter().convert(quizDataString);

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
          child: Text('記述問題'),
        ),
        backgroundColor: Colors.blue[300],
      ),
      body: quizQuestions.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : QuizWidget(
              quizQuestions, index, _judgeSign, judgeAnswer),
    );
  }
}

// ignore: must_be_immutable
class QuizWidget extends StatelessWidget {
  QuizWidget(this.quizQuestions, this.index, this._judgeSign, 
              this.judgeAnswer, {super.key});

  final List<QuizQuestion> quizQuestions;
  final int index;
  final Function judgeAnswer;
  final Widget _judgeSign;

  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Stack(children: [
          Center(
            child: _judgeSign,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Q${index + 1}: ${quizQuestions[index + 1].question}',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _answerController,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () { onPressedAnswer(); },
                        child: const Text('Answer'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void onPressedAnswer() {
    if (_judgeSign.toString() == (const Text("")).toString()) {
      if (_answerController.text.toLowerCase()
            == quizQuestions[index + 1].correctAnswer.toLowerCase()) {
        judgeAnswer(true);
      } else {
        judgeAnswer(false);
      }
    }
  }
}
