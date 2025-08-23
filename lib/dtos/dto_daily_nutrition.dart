class DailyNutrition {
  int calories;
  double proteins;
  double fat;
  double carbs;
  Map<String, List<String>> meals;
  DateTime date;

  DailyNutrition({
    required this.calories,
    required this.proteins,
    required this.fat,
    required this.carbs,
    Map<String, List<String>>? meals,
    DateTime? date,
  })  : meals = meals ??
            {
              "Breakfast": [],
              "Lunch": [],
              "Dinner": [],
              "Snacks": [],
            },
        date = date ?? DateTime.now();

  void addMealItem(String mealType, String item) {
    if (meals.containsKey(mealType)) {
      meals[mealType]!.add(item);
    }
  }
}
