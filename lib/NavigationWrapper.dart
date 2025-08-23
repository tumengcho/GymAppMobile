import 'package:flutter/material.dart';
import 'package:gymapp/pages/page_calorie_calculator.dart';
import 'package:gymapp/pages/page_calorie_tracker.dart';
import 'package:gymapp/pages/page_home.dart';
import 'package:gymapp/pages/page_list_exercises.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Colors.black,
        indicatorColor: const Color(0xFFD3FF55),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home, color: Colors.white),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.fitness_center),
            icon: Icon(Icons.fitness_center, color: Colors.white),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.fastfood),
            icon: Icon(Icons.fastfood, color: Colors.white),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.calculate),
            icon: Icon(Icons.calculate, color: Colors.white),
            label: '',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        HomePage(),

        /// List Exercises Page
        ListExercisesPage(),

        /// Calorie Tracker
        CalorieTracker(),

        /// Calorie Calculator Page
        CalorieCalculatorPage(),
      ][currentPageIndex],
    );
  }
}
