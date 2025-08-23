import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DonutChartExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = [
      _ChartData('Red', 40, Colors.red),
      _ChartData('Green', 30, Colors.green),
      _ChartData('Blue', 75, Colors.blue),

    ];

    return Center(
      child: SfCircularChart(
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '1560',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
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
            cornerStyle: CornerStyle.bothCurve,
            explode: true,
            explodeAll: true,
            explodeOffset: '5%', // gap between arcs
            dataLabelSettings: DataLabelSettings(isVisible: false),
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
