import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/components/component_program_card.dart';
import 'package:gymapp/components/component_gym_calendar.dart';
import 'package:gymapp/dtos/dto_program.dart';
import 'package:gymapp/service/service_database.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Program>? Programs; // Les programes sont null au début.

  /// Récupère les programmes depuis la BD
  void getPrograms() async {
    var programs = await Database.getMyPrograms();
    setState(() {
      Programs = programs;
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
                Row(
                  children: [
                    Text('Salut '.toUpperCase(), // default text
                        style: const TextStyle(fontSize: 25)),
                    Text(
                      'Christopher,'.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w900),
                    ).animate().fadeIn().shimmer(color: const Color(0xFFD3FF55), duration: 2.seconds),
                  ],
                ).animate().slideY(begin: -0.3, end: 0),
                const SizedBox(height: 5),
                Text(
                  getGreeting(),
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ).animate().slideX(begin: -0.3, end: 0).fadeIn(duration: 1.5.seconds),
                const SizedBox(height: 35),
                GymCalendar().animate().fadeIn().shimmer(),
                const SizedBox(height: 35),
                Text(
                  "Mes Programmes".toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      letterSpacing: 1),
                ),
                const SizedBox(height: 15),
                Programs != null
                    ? Column(
                        children: List.generate(
                            4,
                            (index) => ProgramCard(program: Programs![index])
                                .animate()
                                .fadeIn(delay: (100 * index).ms)),
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
