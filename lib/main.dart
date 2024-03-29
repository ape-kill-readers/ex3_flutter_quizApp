import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const HomeScreen(),
        theme: ThemeData(
          fontFamily: 'IPAex',
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.yellow[500],
            iconTheme: const IconThemeData(
              color: Colors.black87,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.black87,
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              primary: Colors.black87,
            )
          ),
        ),
        debugShowCheckedModeBanner: false,
      );
  }
}