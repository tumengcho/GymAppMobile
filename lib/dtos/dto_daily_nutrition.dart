import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymapp/dtos/dto_product_info.dart';

const Map<String, Color> MealCardColors = {
  "Breakfast": Color(0XFF8A38F5),
  "Dinner" : Color(0XFFFF7755),
  "Lunch" : Color(0XFF8CB220),
  "Snacks": Color(0XFFFF0B0B)
};

class DailyNutrition {
  String? id;
  int calories;
  double proteins;
  double fat;
  double carbs;
  Map<String, List<ProductInfo>> meals;
  DateTime date;

  DailyNutrition({
    required this.calories,
    required this.proteins,
    required this.fat,
    required this.carbs,
    Map<String, List<ProductInfo>>? meals,
    DateTime? date,
  })  : meals = meals ??
            {
              "Breakfast": [],
              "Lunch": [],
              "Dinner": [],
              "Snacks": [],
            },
        date = date ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      "calories": calories,
      "proteins": proteins,
      "fat": fat,
      "carbs": carbs,
      "meals": meals.map((k, v) => MapEntry(
          k, List<Map<String, dynamic>>.from(v.map((e) => e.toMap())))),
      "date": date,
    };
  }

  factory DailyNutrition.fromMap(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();

    DailyNutrition daily = DailyNutrition(
      calories: data['calories'] ?? 0,
      proteins: (data['proteins'] ?? 0).toDouble(),
      fat: (data['fat'] ?? 0).toDouble(),
      carbs: (data['carbs'] ?? 0).toDouble(),
      meals: data['meals'] != null
          ? Map<String, List<ProductInfo>>.from(data['meals'].map((k, v) =>
              MapEntry(
                  k,
                  List<ProductInfo>.from(
                      v.map((dynamic e) => ProductInfo.fromMap(e))))))
          : null,
      date: data['date'] != null
          ? (data['date'] as Timestamp).toDate()
          : DateTime.now(),
    );

    daily.id = doc.id;

    return daily;
  }
}
