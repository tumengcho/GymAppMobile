import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:gymapp/dtos/dto_exercise.dart';
import 'package:gymapp/dtos/dto_program.dart';
import 'package:gymapp/dtos/dto_program_exercise.dart';
import 'package:gymapp/main.dart';
import 'package:gymapp/utils/database_collection_enum.dart';
import 'package:gymapp/utils/seed_data.dart';
import 'package:gymapp/utils/utils_class.dart';

/// Réprésente la base de donnée
class Database {

  /// Récupère les exercises associés à un programme.
  static Future<List<ExerciseDTO>> _getExercisesForProgram(String programId) async {

    // Trouver les ProgramExercise correspondant au programme donnée en paramètre
    final relationsSnapshot = await db
        .collection(DatabaseCollectionEntities.programExercise.name)
        .where('programID', isEqualTo: programId)
        .get();

    // On récupère tous les ids des exercise associés
    final exerciseIds =
    relationsSnapshot.docs.map((doc) => doc['exerciseID'] as String).toList();

    if (exerciseIds.isEmpty) return [];

    // On récupère toutes les données des exercises à partir de leur ids
    final exercisesSnapshot = await db
        .collection(DatabaseCollectionEntities.exercises.name)
        .where(FieldPath.documentId, whereIn: exerciseIds)
        .get();

    // On le transforme en classe en on le met dans une liste
    return exercisesSnapshot.docs
        .map((doc) => ExerciseDTO.fromMap(doc))
        .toList();
  }

  /// Récupère les programmes
  static Future<List<Program>> getMyPrograms() async {
    var snapshot =
        await db.collection(DatabaseCollectionEntities.program.name).get();
    List<Program> programs = snapshot.docs.map((doc) => Program.fromMap(doc)).toList();
    for (var program in programs) {
      program.exercises = await _getExercisesForProgram(program.id!);
    }
    return programs;
  }

  /// Récupère les exercises
  static Future<List<ExerciseDTO>> getAllExercises() async {
    var snapshot =
        await db.collection(DatabaseCollectionEntities.exercises.name).get();

    return snapshot.docs.map((doc) => ExerciseDTO.fromMap(doc)).toList();
  }

  /// Ajoute un exercise à un programme
  static Future<void> addExerciseToProgram(ProgramExercise programExercise) async {
    await db
        .collection(DatabaseCollectionEntities.programExercise.name)
        .add(programExercise.toMap());
  }

  /// Sert à nettoyer la base de donnée
  static Future<void> clearDatabase() async {
    final collections = [
      DatabaseCollectionEntities.program,
      DatabaseCollectionEntities.exercises
    ];

    for (final collection in collections) {
      final snapshots = await db.collection(collection.name).get();
      for (final doc in snapshots.docs) {
        await doc.reference.delete();
      }
    }
  }

  /// Sert à créer un seed pour la base de donnée.
  static Future<void> seedDatabase() async {
    await clearDatabase();

    for (Program program in SeedData.programsData) {
      await db
          .collection(DatabaseCollectionEntities.program.name)
          .add(program.toMap());
    }

    for (ExerciseDTO exercise in SeedData.exercisesData) {
      File imageFile =
          await Utils.getImageFileFromAssets("assets/images/${exercise.image}");
      CloudinaryResponse response = await cloudinaryPublic.uploadFile(
        CloudinaryFile.fromFile(imageFile.path,
            folder: 'public',
            publicId:
                "${exercise.name.toLowerCase().replaceAll(" ", "_")}_exo"),
      );
      exercise.image = response.publicId;
      await db
          .collection(DatabaseCollectionEntities.exercises.name)
          .add(exercise.toMap());
    }
  }
}
