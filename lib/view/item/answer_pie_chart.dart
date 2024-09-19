import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnswerPieChart extends StatelessWidget {
  final double percentage;

  const AnswerPieChart({Key? key, required this.percentage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: PieChart(
        PieChartData(
          startDegreeOffset: 270,
          sectionsSpace: 0,
          centerSpaceRadius: 30,
          sections: [
            PieChartSectionData(
                color: Colors.white,
                value: percentage,
                title: '〇\n${percentage.toStringAsFixed(0)}%',
                radius: 50,
                borderSide: BorderSide(color: Colors.black, width: 1),
                titleStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            PieChartSectionData(
              color: Colors.grey[300],
              value: 100 - percentage,
              title: '✕\n${(100 - percentage).toStringAsFixed(0)}%',
              radius: 50,
              borderSide: BorderSide(color: Colors.black, width: 1),
              titleStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        swapAnimationDuration: Duration(milliseconds: 150),
        swapAnimationCurve: Curves.linear,
      ),
    );
  }
}
