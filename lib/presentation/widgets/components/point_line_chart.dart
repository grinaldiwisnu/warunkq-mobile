import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:warunkq_apps/core/models/linear_sales.dart';

class PointLineChart extends StatelessWidget {
  final List<charts.Series<LinearSales, DateTime>> seriesList;
  final bool animate;

  PointLineChart(this.seriesList, {required this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      defaultRenderer: charts.LineRendererConfig(includePoints: true),
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}
