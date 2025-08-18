class ProgramExercise {
  String? id;
  String? programID;
  String? exerciseID;

  ProgramExercise(this.programID, this.exerciseID);

  Map<String, dynamic> toMap() {
    return {
      "programID": programID,
      "exerciseID": exerciseID,
    };
  }
}