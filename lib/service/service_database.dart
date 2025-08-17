import 'package:gymapp/dtos/dto_category_exercise.dart';
import 'package:gymapp/main.dart';

class Database {
  static Future<List<CategoryExercise>> getMyPrograms() async {
    var snapshot = await db.collection("program").get();

    return snapshot.docs
        .map((doc) => CategoryExercise(doc.data()["name"], doc.data()["image"]))
        .toList();
  }

  static Future<void> seedDatabase() async {
    List<CategoryExercise> categoryExercises = [
      CategoryExercise("Dos",
          "https://e1.pxfuel.com/desktop-wallpaper/64/982/desktop-wallpaper-bodybuilding-back.jpg"),
      CategoryExercise("Biceps",
          "https://img.freepik.com/photos-premium/bel-homme-athletique-fort-pompage-muscles-seance-entrainement-remise-forme-concept-musculation-arriere-plan-bodybuilder-musculaire-hommes-remise-forme-faisant-exercices-dos-pour-bras-dans-salle-gym-torse-nu_174475-113.jpg"),
      CategoryExercise("Abdos",
          "https://media.istockphoto.com/id/1007250098/fr/vid%C3%A9o/il-comprend-limportance-de-ses-principaux-atouts.jpg?s=640x640&k=20&c=fGEwjaZLWCvI3hw1EwhqvF4xwyPDQ5-tFHmAPAE0i0w="),
      CategoryExercise("Jambes",
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRljLtLyByZAMXZjoKMO-l_uqfEjQgNu5rrPg&s"),
    ];

    for (var e in categoryExercises) {
      await db
          .collection('program')
          .add({"name": e.name, "image": "${e.name.toLowerCase()}_category"});
    }
  }
}
