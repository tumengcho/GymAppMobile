import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/dtos/dto_exercise.dart';

class ExerciseListItem extends StatefulWidget {
  ExerciseDTO exercise;

  ExerciseListItem({super.key, required this.exercise});

  @override
  State<ExerciseListItem> createState() => _ExerciseListItemState();
}

class _ExerciseListItemState extends State<ExerciseListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 90,
        decoration: BoxDecoration(
            color: const Color(0XFF141414),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0XFFD3FF55), width: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.exercise.name,
              style: const TextStyle(
                  color: Color(0XFFD3FF55),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("12 reps", style: TextStyle(color: Color(0XFFD3FF55))),
                Text("3 sets", style: TextStyle(color: Color(0XFFD3FF55)))
              ],
            )
          ],
        ));
  }
}
