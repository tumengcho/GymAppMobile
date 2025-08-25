import 'package:flutter/material.dart';
import 'package:gymapp/components/component_exercise_list_item.dart';
import 'package:gymapp/dtos/dto_program.dart';
import 'package:gymapp/main.dart';

/// Component pour un programme.
/// Affiche les informations d'un programme dans une card à partir de la BD.

class ProgramCard extends StatefulWidget {
  Program program;

  ProgramCard({super.key, required this.program});

  @override
  State<ProgramCard> createState() => _ProgramCardState();
}

class _ProgramCardState extends State<ProgramCard> {
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
          width: 0.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(10, 10),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(
            cloudinaryPublic.getImage(widget.program.image).url,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
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
            Text(
              "${widget.program.exercises.length} excercices",
              textAlign: TextAlign.end,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.program.name.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2)),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_circle_right,
                    size: 35,
                    color: Color(0xFFD3FF55),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(32),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Color(0XFF090808),
                          ),
                          child: widget.program.exercises.isNotEmpty
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(
                                              widget.program.exercises.length,
                                              (index) => ExerciseListItem(
                                                  exercise: widget.program
                                                      .exercises[index])),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                const Color(0xFFD3FF55)),
                                      ),
                                      onPressed: () => {
                                        Navigator.pop(context),
                                        Navigator.pushNamed(
                                            context, "/startProgram",
                                            arguments: widget.program.exercises)
                                      },
                                      child: const Text(
                                        'Commencer',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                )
                              : const Center(
                                  child:
                                      Text("Aucun exercise pour ce programme."),
                                ),
                        );
                      },
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
