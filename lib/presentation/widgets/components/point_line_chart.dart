import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PointLineChart extends StatelessWidget {
  final List<charts.Series<LinearSales, int>> seriesList;
  final bool animate;

  PointLineChart(this.seriesList, {required this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory PointLineChart.withSampleData() {
    return PointLineChart(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(
      seriesList,
      animate: animate,
      defaultRenderer: charts.LineRendererConfig(includePoints: true),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      LinearSales(0, 0),
      LinearSales(1, 5),
      LinearSales(2, 25),
      LinearSales(3, 100),
      LinearSales(4, 75),
      LinearSales(5, 75),
      LinearSales(6, 75),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.days,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class LinearSales {
  final int days;
  final int sales;

  LinearSales(this.days, this.sales);
}
