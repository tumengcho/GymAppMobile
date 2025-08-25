import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gymapp/components/component_steps_renderer.dart';
import 'package:gymapp/dtos/dto_exercise.dart';
import 'package:gymapp/utils/utils_class.dart';

import '../main.dart';

class ExercisePage extends StatefulWidget {
  List<ExerciseDTO> exercises;

  ExercisePage({super.key, required this.exercises});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  bool startedProgram = false;
  bool isBreak = false;
  int currentExerciseIndex = 0;
  int timeExercise = 0;
  String breakQuote = "";

  Timer? timer;

  void startTimer() async {
    if (timer != null && timer!.isActive) return;
    await audioPlayer.play(AssetSource('sounds/exercise_start.mp3'));
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        timeExercise++;
      });
    });
  }

  void pauseTimer() {
    setState(() {
      timer?.cancel();
    });
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      timeExercise = 0;
    });
  }

  Future<void> next() async {
    if (currentExerciseIndex < widget.exercises.length - 1) {
      isBreak = true;
      resetTimer();
      currentExerciseIndex++;
      breakQuote = await Utils.getRandomBreakQuote();
      setState(() {});
    } else {
      Navigator.pop(context);
    }
  }

  void previous() {
    if (currentExerciseIndex > 0) {
      setState(() {
        currentExerciseIndex--;
        resetTimer();
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: startedProgram
          ? isBreak
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Break".toUpperCase(),
                          style: const TextStyle(
                              color: Color(0xFFD3FF55),
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2),
                        ),
                        CircularCountDownTimer(
                          duration: 15,
                          initialDuration: 0,
                          controller: CountDownController(),
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 2,
                          ringColor: Colors.grey[300]!,
                          ringGradient: null,
                          fillColor: const Color(0xFFD3FF55),
                          fillGradient: null,
                          backgroundColor: Colors.transparent,
                          backgroundGradient: null,
                          strokeWidth: 20.0,
                          strokeCap: StrokeCap.round,
                          textStyle: const TextStyle(
                              fontSize: 33.0,
                              color: Color(0xFFD3FF55),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          textFormat: CountdownTextFormat.S,
                          isReverse: true,
                          isReverseAnimation: false,
                          isTimerTextShown: true,
                          autoStart: true,
                          onStart: () async {
                            await audioPlayer
                                .play(AssetSource('sounds/waiting.mp3'));
                          },
                          onComplete: () {
                            audioPlayer.stop();
                            setState(() {
                              isBreak = false;
                            });
                          },
                          timeFormatterFunction:
                              (defaultFormatterFunction, duration) {
                            if (duration.inSeconds == 0) {
                              return "Fin";
                            } else {
                              return Function.apply(
                                  defaultFormatterFunction, [duration]);
                            }
                          },
                        ),
                        AnimatedTextKit(
                          totalRepeatCount: 1,
                          isRepeatingAnimation: false,
                          animatedTexts: [
                            TypewriterAnimatedText(breakQuote.toUpperCase(),
                                speed: 100.ms,
                                textAlign: TextAlign.center,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                        flex: 7,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                cloudinaryPublic
                                    .getImage(widget
                                        .exercises[currentExerciseIndex].image)
                                    .url,
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedTextKit(
                                key: ValueKey(currentExerciseIndex),
                                repeatForever: false,
                                totalRepeatCount: 1,
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                  TyperAnimatedText(
                                    widget.exercises[currentExerciseIndex].name.toUpperCase(),
                                    speed: 100.ms,
                                    textStyle: const TextStyle(
                                        color: Color(0xFFD3FF55),
                                        fontSize: 30,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 2),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ).animate().shimmer()),
                    Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: const BoxDecoration(
                            color: Color(0xFFD3FF55),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Breaks".toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Color(0xFF323230),
                                              letterSpacing: 2,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          (widget.exercises.length -
                                                  currentExerciseIndex -
                                                  1)
                                              .toString(),
                                          style: const TextStyle(
                                              color: Color(0xFF323230),
                                              fontSize: 25,
                                              fontWeight: FontWeight.w900))
                                    ],
                                  ),
                                  Expanded(
                                    child: Text(
                                      Utils.formatTime(timeExercise),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Color(0xFF323230),
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Répétitions".toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Color(0xFF323230),
                                              letterSpacing: 2,
                                              fontWeight: FontWeight.bold)),
                                      const Text("12",
                                          style: TextStyle(
                                              color: Color(0xFF323230),
                                              fontSize: 25,
                                              fontWeight: FontWeight.w900))
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      onPressed: previous,
                                      icon: const Icon(
                                        Icons.skip_previous_rounded,
                                        size: 60,
                                        color: Color(0xFF323230),
                                      )),
                                  timer != null && timer!.isActive
                                      ? IconButton(
                                          onPressed: pauseTimer,
                                          icon: const Icon(
                                            Icons.pause,
                                            size: 100,
                                            color: Color(0xFF323230),
                                          ))
                                      : IconButton(
                                          onPressed: startTimer,
                                          icon: const Icon(
                                            Icons.play_arrow_rounded,
                                            size: 100,
                                            color: Color(0xFF323230),
                                          )),
                                  IconButton(
                                      onPressed: next,
                                      icon: const Icon(
                                        Icons.skip_next_rounded,
                                        size: 60,
                                        color: Color(0xFF323230),
                                      ))
                                ],
                              ),
                              const Expanded(child: SizedBox()),
                              StepsRenderer(
                                numSteps: widget.exercises.length,
                                currentStep: currentExerciseIndex,
                              )
                            ],
                          ),
                        ).animate().fadeIn().slideY(begin: 0.5, end: 0))
                  ],
                )
          : Center(
              child: CircularCountDownTimer(
                duration: 5,
                initialDuration: 0,
                controller: CountDownController(),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                ringColor: Colors.grey[300]!,
                ringGradient: null,
                fillColor: const Color(0xFFD3FF55),
                fillGradient: null,
                backgroundColor: Colors.transparent,
                backgroundGradient: null,
                strokeWidth: 20.0,
                strokeCap: StrokeCap.round,
                textStyle: const TextStyle(
                    fontSize: 33.0,
                    color: Color(0xFFD3FF55),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                textFormat: CountdownTextFormat.S,
                isReverse: true,
                isReverseAnimation: false,
                isTimerTextShown: true,
                autoStart: true,
                onStart: () async {
                  await audioPlayer
                      .play(AssetSource('sounds/program_start.mp3'));
                },
                onComplete: () {
                  setState(() {
                    startedProgram = true;
                  });
                },
                timeFormatterFunction: (defaultFormatterFunction, duration) {
                  if (duration.inSeconds == 0) {
                    return "Start";
                  } else {
                    return Function.apply(defaultFormatterFunction, [duration]);
                  }
                },
              ),
            ),
    );
  }
}
