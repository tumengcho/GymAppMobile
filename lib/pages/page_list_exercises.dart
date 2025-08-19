import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:gymapp/dtos/dto_exercise.dart';
import 'package:gymapp/dtos/dto_program_exercise.dart';
import 'package:gymapp/service/service_database.dart';

import '../components/component_card_exercise.dart';
import '../dtos/dto_program.dart';

class ListExercisesPage extends StatefulWidget {
  const ListExercisesPage({super.key});

  @override
  State<ListExercisesPage> createState() => _ListExercisesPageState();
}

class _ListExercisesPageState extends State<ListExercisesPage> {
  final CardSwiperController controller = CardSwiperController();
  List<Program>? programs;
  List<ExerciseDTO>? exercises;
  List<ExerciseDTO> displayExercises = [];
  Program? selectedProgram;
  bool isAddingExercise = false;

  @override
  void initState() {
    super.initState();
    getAllExercisesAndPrograms();
  }

  void getAllExercisesAndPrograms() async {
    var exercisesResult = await Database.getAllExercises();
    var programsResult = await Database.getMyPrograms();

    setState(() {
      exercises = exercisesResult;
      programs = programsResult;
      selectedProgram = programsResult[0];
    });

    removeExistingExercises();
  }

  void removeExistingExercises() {
    displayExercises.clear();
    setState(() {
      displayExercises = List.from(exercises!);
      displayExercises.removeWhere((exo) => selectedProgram!.exercises
          .any((exoProgram) => exoProgram.id == exo.id));
    });
  }

  Future<bool> _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) async {
    if (direction == CardSwiperDirection.right) {
      setState(() {
        isAddingExercise = true;
      });
      ExerciseDTO selectedExcercise = displayExercises[previousIndex!];
      ProgramExercise newExerciceProgram =
          ProgramExercise(selectedProgram?.id, selectedExcercise.id);
      await Database.addExerciseToProgram(newExerciceProgram);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16),
              children: [
                const TextSpan(text: "L'exercice "),
                TextSpan(
                  text: selectedExcercise.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const TextSpan(text: " a été ajouté au programme "),
                TextSpan(
                  text: selectedProgram!.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
          duration: Duration(seconds: 2),
        ),
      );

      setState(() {
        isAddingExercise = false;
        displayExercises.remove(selectedExcercise);
      });
    }
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    ExerciseDTO selectedExcercise = displayExercises[previousIndex!];
    displayExercises.remove(selectedExcercise);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: exercises != null
            ? Column(
                children: [
                  DropdownButton<Program>(
                    style: const TextStyle(color: Colors.white),
                    dropdownColor: Colors.black,
                    value: selectedProgram,
                    hint: const Text('Choisissez un programme.'),
                    items: programs!
                        .map<DropdownMenuItem<Program>>((Program program) {
                      return DropdownMenuItem<Program>(
                        value: program,
                        child: Text(program.name),
                      );
                    }).toList(),
                    onChanged: (Program? newProgram) {
                      setState(() {
                        selectedProgram = newProgram;
                      });
                      removeExistingExercises();
                    },
                  ),
                  displayExercises.isEmpty
                      ? const Center(
                          child:
                              Text("Aucune carte possible pour ce programme."))
                      : Flexible(
                          child: CardSwiper(
                              key: ValueKey(selectedProgram!.id),
                              controller: controller,
                              cardsCount: displayExercises.length,
                              onSwipe: _onSwipe,
                              onUndo: _onUndo,
                              isLoop: false,
                              isDisabled: isAddingExercise,
                              numberOfCardsDisplayed:
                                  displayExercises.length > 1 ? 3 : 1,
                              backCardOffset: const Offset(30, 0),
                              padding: const EdgeInsets.all(24.0),
                              cardBuilder: (
                                context,
                                index,
                                horizontalThresholdPercentage,
                                verticalThresholdPercentage,
                              ) =>
                                  CardExercise(
                                      exercise: displayExercises[index])),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          onPressed: () =>
                              controller.swipe(CardSwiperDirection.left),
                          backgroundColor: Color(0xFF323230),
                          elevation: 0,
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: controller.undo,
                          backgroundColor: Color(0xFF323230),
                          elevation: 0,
                          child: const Icon(
                            Icons.rotate_left,
                            color: Colors.blue,
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: () =>
                              controller.swipe(CardSwiperDirection.right),
                          backgroundColor: const Color(0xFF323230),
                          elevation: 0,
                          child: const Icon(Icons.favorite, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(color: Color(0xFFD3FF55))),
      ),
    );
  }
}
