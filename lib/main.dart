import 'package:flutter/material.dart';
import 'package:gymapp/NavigationWrapper.dart';
import 'package:gymapp/pages/page_calorie_calculator.dart';
import 'package:gymapp/pages/page_exercise.dart';
import 'package:gymapp/pages/page_list_exercises.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: Color(0xFFD3FF55),
        scaffoldBackgroundColor: Color(0xFF323230),
        textTheme: TextTheme(
            bodySmall: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
            bodyLarge: TextStyle(color: Colors.white),
        ),
        useMaterial3: true,
      ),
      home: NavigationWrapper(),
    );
  }
}
