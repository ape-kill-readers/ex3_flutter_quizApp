import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'result_screen.dart';

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
          MaterialPageRoute(builder: (context) => ResultScreen(score: result, maxScore: (quizQuestions.length - 1))),
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
          child: Text('4択クイズ'),
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
  const QuizWidget(this.quizQuestions, this.index, this._judgeSign, 
              this.judgeAnswer, {super.key});

  final List<QuizQuestion> quizQuestions;
  final int index;
  final Function judgeAnswer;
  final Widget _judgeSign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Stack(children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: 250,
                  height: 200,
                  child: Center(
                    child: Text(
                      quizQuestions[index + 1].question,
                      style: const TextStyle(fontSize: 60.0),
                    ),
                  ),
                ),
                Column(
                  children: 
                    quizQuestions[index + 1].options.map(
                      (options) => buildChoiceButton(options)
                    ).toList()
                ),
              ],
            ),
          ),
          Center(
            child: _judgeSign,
          ),
        ]),
      ),
    );
  }

  Widget buildChoiceButton(String choiceText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: OutlinedButton(
        onPressed: () { onPressedChoice(choiceText); },
        child: SizedBox(
          width: 300,
          height: 40,
          child: Center(child: Text(choiceText, style: const TextStyle(fontSize: 20.0)))
        ),
      ),
    );
  }

  void onPressedChoice(String answer) {
    if (_judgeSign.toString() == (const Text("")).toString()) {
      if (answer == quizQuestions[index + 1].correctAnswer) {
        judgeAnswer(true);
      } else {
        judgeAnswer(false);
      }
    }
  }
}
