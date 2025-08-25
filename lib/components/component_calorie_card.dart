import 'package:flutter/material.dart';

import '../utils/bmr_enum.dart';

class CalorieCard extends StatelessWidget {
  BMRCategory type;
  double calorie;
  Color color;
  IconData icon;
  CalorieCard({super.key, required this.type, required this.calorie}) :
  color =  type == BMRCategory.Gain ? const Color(0XFF6C881C) : type == BMRCategory.Maintien ? const Color(0XFF9F9F13) : const Color(0XFFE86E4F),
  icon = type == BMRCategory.Gain ? Icons.trending_up : type == BMRCategory.Maintien ? Icons.trending_flat : Icons.trending_down;



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            colors: [
              const Color(0xFF323230),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.5, 1])
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 35,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5)
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type.name,
                      style: const TextStyle( fontSize: 12),

                    ),
                    Text(
                      calorie.toStringAsFixed(0),
                      style: TextStyle(color: color,fontWeight: FontWeight.w900, fontSize: 25),
                    ),
                  ],
                ),
                Icon(icon, color: Colors.white, size: 30,)
              ],

            ),
          ),
        ],
      ),
    );
  }
}
