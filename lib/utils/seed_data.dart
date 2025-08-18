import 'package:gymapp/dtos/dto_exercise.dart';

import '../dtos/dto_program.dart';
import 'category_enum.dart';

class SeedData{
  static List<ExerciseDTO> exercisesData = [
    ExerciseDTO("Dumbbell Bicep Curl", CategoryExercise.Biceps, 2, "biceps_curl.png"),
    ExerciseDTO("Bench Press", CategoryExercise.Pectoraux, 4, "bench_press.png"),
    ExerciseDTO("Deadlift", CategoryExercise.FullBody, 5, "deadlift.png"),
    ExerciseDTO("Jump Squat", CategoryExercise.Quadriceps, 4, "squat.png"),
    ExerciseDTO("Shoulder Press", CategoryExercise.Epaules, 3, "shoulder_press.png"),
    ExerciseDTO("Triceps Dip", CategoryExercise.Triceps, 2, "dips.png"),
  ];

  static List<Program> programsData = [
    Program("Dos", "dos_category"),
    Program("Biceps", "biceps_category"),
    Program("Abdos", "abdos_category"),
    Program("Jambes", "jambes_category"),
  ];
}