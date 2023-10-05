import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class BarChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bar Chart Example'),
      ),
      body: Echarts(
        option: '''
        {
          xAxis: {
            type: 'category',
            data: ['Category 1', 'Category 2', 'Category 3', 'Category 4', 'Category 5'],
          },
          yAxis: {
            type: 'value',
          },
          series: [
            {
              type: 'bar',
              data: [120, 200, 150, 80, 70],
            },
          ],
        }
        ''',
      ),
    );
  }
}
