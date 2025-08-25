import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymapp/components/component_donut_pie_chart.dart';
import 'package:gymapp/dtos/dto_daily_nutrition.dart';
import 'package:gymapp/dtos/dto_product_info.dart';
import 'package:gymapp/service/service_database.dart';

class CalorieTracker extends StatefulWidget {
  const CalorieTracker({super.key});

  @override
  State<CalorieTracker> createState() => _CalorieTrackerState();
}

class _CalorieTrackerState extends State<CalorieTracker> with RouteAware {
  DailyNutrition? dailyNutrition;


  void initialize() async {
    DailyNutrition? resultNutrition = await Database.getLastMealTracking();

    resultNutrition ??= await Database.addNewMealTracking();
    if (!mounted) return;
    setState(() {
      dailyNutrition = resultNutrition;
    });
  }

  double calculateCalories(List<ProductInfo> products) {
    double calories = 0;

    products.forEach((p) => calories += p.calories);

    return calories;
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: dailyNutrition != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Calories Consumption",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 25),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border:
                          Border.all(color: const Color(0XFFD3FF55), width: 1),
                      gradient: const LinearGradient(
                        colors: [Color(0XFFC0E84F), Color(0XFF33332F)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: CalorieDonutChart(
                        nutritionInfos: dailyNutrition!,
                      )),
                      const SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)),
                                child: SvgPicture.asset(
                                  'assets/icons/steak.svg',
                                  width: 20,
                                  height: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${dailyNutrition!.proteins}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18),
                                  ),
                                  const Text("Proteins"),
                                ],
                              ),
                            ],
                          ).animate().fadeIn(delay: 100.ms),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)),
                                child: SvgPicture.asset(
                                  'assets/icons/avocado.svg',
                                  width: 20,
                                  height: 20,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${dailyNutrition!.fat}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18),
                                  ),
                                  const Text("Fat"),
                                ],
                              ),
                            ],
                          ).animate().fadeIn(delay: 200.ms),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)),
                                child: SvgPicture.asset(
                                  'assets/icons/bread.svg',
                                  width: 20,
                                  height: 20,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${dailyNutrition!.carbs}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18),
                                  ),
                                  const Text("Calbs"),
                                ],
                              ),
                            ],
                          ).animate().fadeIn(delay: 300.ms),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
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
                                  String currentMealName = dailyNutrition!
                                      .meals.keys
                                      .elementAt(index);

                                  return Stack(
                                    children: [
                                      Container(
                                        width: double.maxFinite,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xFFD3FF55),
                                              width: 1),
                                          gradient: LinearGradient(
                                            colors: [
                                              MealCardColors[currentMealName] ?? Colors.blue,
                                              (MealCardColors[currentMealName] ?? Colors.blue)
                                                  .withOpacity(0.3)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                            const SizedBox(height: 10),
                                            Text(
                                              currentMealName.toUpperCase(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  letterSpacing: 3),
                                            ),
                                            const SizedBox(height: 3),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: calculateCalories(
                                                            dailyNutrition!
                                                                    .meals[
                                                                currentMealName]!)
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Color(0xFFD3FF55),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: " kcal 🔥",
                                                    style:
                                                        TextStyle(fontSize: 12),
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
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                                Icons.add_circle_sharp,
                                                color: Color(0xFFD3FF55),
                                                size: 40),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                      context, "/searchMeal",
                                                      arguments:
                                                          currentMealName)
                                                  .then(
                                                      (value) => initialize());
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      .animate()
                                      .fadeIn(delay: (index * 300).ms)
                                      .shimmer();
                                }),
                              ),
                              const Center(
                                  child: Text("This is Option 2 view")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFD3FF55),
              ),
            ),
    );
  }
}
