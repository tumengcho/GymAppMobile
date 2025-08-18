import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/components/component_star_renderer.dart';
import 'package:gymapp/dtos/dto_exercise.dart';

import '../main.dart';

class CardExercise extends StatelessWidget {
  ExerciseDTO exercise;

  CardExercise({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xFF323230),
          border: Border.all(
            color: Color(0xFFD3FF55),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Image.network(
                cloudinaryPublic.getImage(exercise.image).url,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF323230),
                        Color(0xFF9ABE33),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.3, 1]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            exercise.name.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 27, fontWeight: FontWeight.w900),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(exercise.category.name,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic)),
                    ),
                    Expanded( flex: 1,child: StarRenderer(numStars: exercise.difficulty))
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
