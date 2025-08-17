import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            const Text(
              "8 excercices",
              textAlign: TextAlign.end,
              style: TextStyle(
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
                const Icon(
                  Icons.arrow_circle_right,
                  size: 35,
                  color: Color(0xFFD3FF55),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
