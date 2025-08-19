import 'package:flutter/material.dart';

import '../utils/bmr_enum.dart';

class CalorieCard extends StatelessWidget {
  BMRCategory type;
  double calorie;
  Color color;
  IconData icon;
  CalorieCard({super.key, required this.type, required this.calorie}) :
  color =  type == BMRCategory.Gain ? Color(0XFF6C881C) : type == BMRCategory.Maintien ? Color(0XFF9F9F13) : Color(0XFFE86E4F),
  icon = type == BMRCategory.Gain ? Icons.trending_up : type == BMRCategory.Maintien ? Icons.trending_flat : Icons.trending_down;



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            colors: [
              Color(0xFF323230),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.5, 1])
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
          SizedBox(width: 5),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type.name,
                      style: TextStyle( fontSize: 12),

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
