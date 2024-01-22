import 'package:flutter/material.dart';
import 'screens/first_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FirstScreen(),
        theme: ThemeData(
          fontFamily: 'IPAex',
        )
      );
  }
}