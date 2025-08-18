import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymapp/dtos/dto_exercise.dart';
import 'package:gymapp/service/service_database.dart';

class Program {
  String? id;
  String name;
  String image;
  List<ExerciseDTO> exercises = [];

  Program(this.name, this.image);

  factory Program.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> doc) {

    Program program = Program(
      doc.data()['name'] ?? '',
      doc.data()['image'] ?? '',
    );
    program.id = doc.id;
    return program;
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "image": image,
    };
  }
}
