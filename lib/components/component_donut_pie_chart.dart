import 'package:flutter/material.dart';
import 'package:gymapp/dtos/dto_daily_nutrition.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CalorieDonutChart extends StatelessWidget {
  DailyNutrition nutritionInfos;

  CalorieDonutChart({super.key, required this.nutritionInfos});

  @override
  Widget build(BuildContext context) {
    final data = [
      _ChartData('Proteins', nutritionInfos.proteins, Colors.red),
      _ChartData('Fats', nutritionInfos.fat, Colors.green),
      _ChartData('Carbs', nutritionInfos.carbs, Colors.blue),
    ];

    return Center(
      child: SfCircularChart(
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${nutritionInfos.calories}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'kcal',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
        series: <CircularSeries>[
          DoughnutSeries<_ChartData, String>(
            dataSource: data,
            xValueMapper: (_ChartData data, _) => data.label,
            yValueMapper: (_ChartData data, _) => data.value,
            pointColorMapper: (_ChartData data, _) => data.color,
            radius: '100%',
            innerRadius: '50%',
            cornerStyle: CornerStyle.bothFlat,
            explode: true,
            explodeAll: true,
            explodeOffset: '5%',
            dataLabelSettings: const DataLabelSettings(isVisible: false),
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  final String label;
  final double value;
  final Color color;

  _ChartData(this.label, this.value, this.color);
}
