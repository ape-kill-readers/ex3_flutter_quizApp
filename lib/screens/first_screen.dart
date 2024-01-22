import 'package:flutter/material.dart';
import 'second_screen.dart';

class FirstScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Text('英単語'),
        ),
        backgroundColor: Colors.blue[300],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
          // Navigate to the second screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
          },
          child: const Text('Go to Second Screen'),
        ),
      ),
    );
  }
}