import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/dtos/dto_category_exercise.dart';

class CategoryExerciseCard extends StatefulWidget {

  CategoryExercise categoryExercise;

  CategoryExerciseCard({super.key, required this.categoryExercise});

  @override
  State<CategoryExerciseCard> createState() => _CategoryExerciseCardState();
}

class _CategoryExerciseCardState extends State<CategoryExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      height: 250,
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFD3FF55),
          width: 1,
        ),
        image: DecorationImage(
          image: NetworkImage(
              widget.categoryExercise.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0XFF6C881C),
                Colors.transparent,
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              stops: [0.04, 1]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text("8 excercices", textAlign: TextAlign.end, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.categoryExercise.name.toUpperCase(),  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 2)),
                const Icon(Icons.arrow_circle_right, size: 35, color: Color(0xFFD3FF55),)

              ],
            )
          ],
        ),
      ),
    );
  }
}
