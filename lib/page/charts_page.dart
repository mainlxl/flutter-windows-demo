import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MultiLineChart extends StatelessWidget {
  double yGap = 1500000;
  int yCount = 128;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SfCartesianChart(
        primaryXAxis: NumericAxis(
          title: AxisTitle(text: '采样率'),
          interval: 1, // 设置 x 轴的间隔
        ),
        primaryYAxis: NumericAxis(
          isVisible: true,
          // 纵轴可见
          minimum: 0,
          maximum: yGap * yCount,
          // 设置纵轴的范围
          axisLabelFormatter: (AxisLabelRenderDetails args) =>
              ChartAxisLabel('', null),
        ),
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          // 启用捏合缩放
          enableDoubleTapZooming: true,
          // 启用双击缩放
          enablePanning: true,
          // 启用平移
          enableSelectionZooming: true,
          // 启用选择框缩放
          enableMouseWheelZooming: true,
          // 启用鼠标滚轮缩放
          zoomMode: ZoomMode.xy,
          // 同时启用 X 和 Y 轴方向的缩放
          maximumZoomLevel: 0.1,
          // 最大缩放级别
          selectionRectBorderWidth: 2,
          // 设置选择框边框宽度
          selectionRectBorderColor: Colors.blue,
          // 设置选择框边框颜色
          selectionRectColor: Colors.blue.withOpacity(0.3), // 设置选择框填充颜色
        ),
        plotAreaBorderWidth: 0,
        series: _getSeries(yGap, yCount),
      ),
    );
  }

  List<LineSeries<ChartData, num>> _getSeries(double yGap, int yDataCount) {
    List<LineSeries<ChartData, num>> res = [];
    double yStart = 0;
    for (int i = 0; i < yDataCount; i++) {
      final List<ChartData> data1 = _getChartData(100, yStart);
      res.add(LineSeries<ChartData, num>(
        dataSource: data1,
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        enableTooltip: true,
      ));
      yStart = i * yGap;
    }
    return res;
  }

  List<ChartData> _getChartData(int dataCount, double yStart) {
    final Random random = Random();
    final List<ChartData> chartData = [];
    for (int i = 0; i < dataCount; i++) {
      chartData.add(ChartData(
          i, (random.nextDouble() * yGap*2) + yStart)); // 生成 0 到 10 之间的随机数
    }
    return chartData;
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final num x;
  final num y;
}
