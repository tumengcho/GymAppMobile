import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/components/component_category_exercise_card.dart';
import 'package:gymapp/components/component_gym_calendar.dart';
import 'package:gymapp/dtos/dto_category_exercise.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<CategoryExercise> categoryExercises = [
    CategoryExercise("Biceps", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1NHvoutGn-Vr_uwVbOOtezhENvx9jhV6pfQ&s"),
    CategoryExercise("Dos", "https://e1.pxfuel.com/desktop-wallpaper/64/982/desktop-wallpaper-bodybuilding-back.jpg"),
    CategoryExercise("Abdos", "https://media.istockphoto.com/id/1007250098/fr/vid%C3%A9o/il-comprend-limportance-de-ses-principaux-atouts.jpg?s=640x640&k=20&c=fGEwjaZLWCvI3hw1EwhqvF4xwyPDQ5-tFHmAPAE0i0w="),
    CategoryExercise("Jambes", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRljLtLyByZAMXZjoKMO-l_uqfEjQgNu5rrPg&s"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Salut '.toUpperCase(), // default text
                  style: const TextStyle(fontSize: 25),
                  children: [
                    TextSpan(
                      text: 'Christopher,'.toUpperCase(),
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              const Text("Bon matin!"),
              const SizedBox(height: 20),
              GymCalendar(),
              SizedBox(height: 35),
              Text("Mes Programmes", style: TextStyle(fontWeight: FontWeight.normal),),
              const SizedBox(height: 15),
              Column(
                children: List.generate(4, (index) => CategoryExerciseCard(categoryExercise: categoryExercises[index])),
              )
              
            ],
          )
        ),
      ),
    );
  }


}
