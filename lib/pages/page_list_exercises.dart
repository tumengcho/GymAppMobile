import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:gymapp/components/component_card_exercise.dart';
import 'package:gymapp/dtos/dto_exercise.dart';

class ListExercisesPage extends StatefulWidget {
  const ListExercisesPage({super.key});

  @override
  State<ListExercisesPage> createState() => _ListExercisesPageState();
}

class _ListExercisesPageState extends State<ListExercisesPage> {
  final CardSwiperController controller = CardSwiperController();

  bool _onSwipe(
      int previousIndex,
      int? currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
      int? previousIndex,
      int currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }

  List<ExerciseDTO> exercises = [
    ExerciseDTO("Dumbbell Bicep Curl", "Biceps", 2, "biceps_curl.png"),
    ExerciseDTO("Bench Press", "Chest", 4, "bench_press.png"),
    ExerciseDTO("Deadlift", "Back", 5, "deadlift.png"),
    ExerciseDTO("Jump Squat", "Legs", 4, "squat.png"),
    ExerciseDTO("Shoulder Press", "Shoulders", 3, "shoulder_press.png"),
    ExerciseDTO("Triceps Dip", "Triceps", 2, "dips.png"),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: CardSwiper(
                controller: controller,
                cardsCount: exercises.length,
                onSwipe: _onSwipe,
                onUndo: _onUndo,
                isLoop: false,
                numberOfCardsDisplayed: 3,
                backCardOffset: const Offset(30, 0),
                padding: const EdgeInsets.all(24.0),
                cardBuilder: (
                    context,
                    index,
                    horizontalThresholdPercentage,
                    verticalThresholdPercentage,
                    ) => CardExercise(exercise: exercises[index])
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () => controller.swipe(CardSwiperDirection.left),
                    backgroundColor: Color(0xFF323230),
                    elevation: 0,
                    child: const Icon(Icons.close, color: Colors.white,),
                  ),
                  FloatingActionButton(
                    onPressed: controller.undo,
                    backgroundColor: Color(0xFF323230),
                    elevation: 0,
                    child: const Icon(Icons.rotate_left, color: Colors.blue,),
                  ),
                  FloatingActionButton(
                    onPressed: () =>
                        controller.swipe(CardSwiperDirection.right),
                    backgroundColor: Color(0xFF323230),
                    elevation: 0,
                    child: const Icon(Icons.favorite, color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
