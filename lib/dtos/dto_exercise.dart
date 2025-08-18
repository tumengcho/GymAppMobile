import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymapp/utils/category_enum.dart';

class ExerciseDTO{
  String? id;
  CategoryExercise category;
  int difficulty;
  String image;
  String name;

  ExerciseDTO(this.name, this.category, this.difficulty, this.image);

  factory ExerciseDTO.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> doc) {

    ExerciseDTO exo = ExerciseDTO(
      doc.data()['name'] ?? '',
      CategoryExercise.values
          .firstWhere(
            (e) => e.name == doc.data()['category'],
        orElse: () => CategoryExercise.Unknown,
      ),
      doc.data()['difficulty'] ?? '',
      doc.data()['image'] ?? '',
    );

    exo.id = doc.id;

    return exo;
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "category": category.name,
      "difficulty": difficulty,
      "image": image,
    };
  }
}