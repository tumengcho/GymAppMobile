import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListExercisesPage extends StatefulWidget {
  const ListExercisesPage({super.key});

  @override
  State<ListExercisesPage> createState() => _ListExercisesPageState();
}

class _ListExercisesPageState extends State<ListExercisesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'List Excercices',
        ),
      ),
    );
  }
}