import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymapp/components/component_donut_pie_chart.dart';
import 'package:gymapp/dtos/dto_daily_nutrition.dart';

class CalorieTracker extends StatefulWidget {
  const CalorieTracker({super.key});

  @override
  State<CalorieTracker> createState() => _CalorieTrackerState();
}

class _CalorieTrackerState extends State<CalorieTracker> {

  DailyNutrition dailyNutrition = DailyNutrition(calories: 1570, proteins: 56, fat: 32, carbs: 24);

  var MealCardColors = [
    Color(0XFF8A38F5),
    Color(0XFFFF7755),
    Color(0XFF8CB220),
    Color(0XFFFF0B0B)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Calories Consumption",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 25),
          Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Color(0XFFD3FF55), width: 1),
                gradient: LinearGradient(
                  colors: [Color(0XFFC0E84F), Color(0XFF33332F)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: DonutChartExample()),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                          child: SvgPicture.asset(
                            'assets/icons/steak.svg', // your SVG file in assets
                            width: 20,
                            height: 20,
                            color: Colors.redAccent,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "56g",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 18),
                            ),
                            Text("Proteins"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                          child: SvgPicture.asset(
                            'assets/icons/avocado.svg',
                            // your SVG file in assets
                            width: 20,
                            height: 20,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Column(
                          children: [
                            Text(
                              "15g",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 18),
                            ),
                            Text("Fat"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                          child: SvgPicture.asset(
                            'assets/icons/bread.svg', // your SVG file in assets
                            width: 20,
                            height: 20,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Text(
                              "56g",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 18),
                            ),
                            Text("Calbs"),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 30),
          DefaultTabController(
            length: 2,
            child: Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0XFF252522),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TabBar(
                      tabs: [
                        Tab(text: "Meals Tracking".toUpperCase()),
                        Tab(text: "Activity".toUpperCase()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1.3,
                          mainAxisSpacing: 20,
                          children: List.generate(4, (index) {

                            String currentMealName = dailyNutrition.meals.keys.elementAt(index);

                            return Stack(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFFD3FF55), width: 1),
                                    gradient: LinearGradient(
                                      colors: [MealCardColors[index], MealCardColors[index].withOpacity(0.3)],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          "assets/images/${currentMealName.toLowerCase()}.png",
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        currentMealName.toUpperCase(),
                                        style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 3),
                                      ),
                                      SizedBox(height: 3),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: (600 + (index * 100)).toString(),
                                              style: TextStyle(
                                                color: Color(0xFFD3FF55),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " kcal 🔥",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: -12,
                                  right: -12,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.add_circle_sharp, color: Color(0xFFD3FF55), size: 40),
                                      onPressed: () {
                                        // your add action
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                        const Center(child: Text("This is Option 2 view")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
