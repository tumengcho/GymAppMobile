import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/components/component_category_exercise_card.dart';
import 'package:gymapp/components/component_gym_calendar.dart';
import 'package:gymapp/dtos/dto_category_exercise.dart';
import 'package:gymapp/service/service_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryExercise>? categoryExercises;

  void getPrograms() async {
    var programs = await Database.getMyPrograms();
    setState(()  {
      categoryExercises = programs;
    });
  }


  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Bon matin !';
    } else if (hour >= 12 && hour < 18) {
      return 'Bonne après midi !';
    } else {
      return 'Bonsoir !';
    }
  }

  @override
  Widget build(BuildContext context) {

    getPrograms();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
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
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  getGreeting(),
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 35),
                GymCalendar(),
                SizedBox(height: 35),
                Text(
                  "Mes Programmes".toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      letterSpacing: 1),
                ),
                const SizedBox(height: 15),
                categoryExercises != null
                    ? Column(
                        children: List.generate(
                            4,
                            (index) => CategoryExerciseCard(
                                categoryExercise: categoryExercises![index])),
                      )
                    : const Center(
                        child:
                            CircularProgressIndicator(color: Color(0xFF323230)),
                      )
              ],
            )),
      ),
    );
  }
}
