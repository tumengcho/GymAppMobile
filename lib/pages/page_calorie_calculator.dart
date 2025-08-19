import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gymapp/components/component_calculate_calorie_form.dart';
import 'package:gymapp/components/component_calorie_card.dart';
import 'package:gymapp/pages/page_exercise.dart';

import '../utils/bmr_enum.dart';

class CalorieCalculatorPage extends StatefulWidget {
  const CalorieCalculatorPage({super.key});

  @override
  State<CalorieCalculatorPage> createState() => _CalorieCalculatorPageState();
}

class _CalorieCalculatorPageState extends State<CalorieCalculatorPage> {

  bool calculated = false;
  List<double> calValues = [];

  void calculate(double poids, double taille, double age, double activityFactor) {
    calValues.clear();
    double BMR = (10 * poids) + (6.25 * taille) - (5 * age) + 5;
    double TDEE = BMR * activityFactor;
    setState(() {
      // Gain
      calValues.add((TDEE + 500));

      // Maintien
      calValues.add((TDEE));

      // Perte
      calValues.add((TDEE - 500));

      calculated = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: const BoxDecoration(
        image: DecorationImage(
          opacity: 0.5,
          image: AssetImage("assets/images/fond_calorie_page.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
          child: Column(
            mainAxisAlignment: calculated
                ? MainAxisAlignment.spaceAround
                : MainAxisAlignment.center,
            children: [
              CalculateCalorieForm(onCalculate: calculate).animate().fadeIn().shimmer(),
              calculated ?
              Column(
                children: List.generate(
                    3, (index) => CalorieCard(type: BMRCategory.values[index], calorie: calValues[index],).animate().fadeIn(duration: (400 * index).ms)),
              ) : const SizedBox.shrink()
            ],
          )),
    );
  }
}
