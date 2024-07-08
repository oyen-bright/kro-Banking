// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InvestmentChart extends StatefulWidget {
  const InvestmentChart({super.key});

  @override
  State<InvestmentChart> createState() => _InvestmentChartState();
}

class _InvestmentChartState extends State<InvestmentChart> {
  TrackballBehavior? _trackballBehavior;
  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        tooltipSettings: const InteractiveTooltip(format: 'point.x : point.y'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDefaultDateTimeAxisChart();
  }

  final data = <ChartSampleData>[
    ChartSampleData(x: DateTime(2015), yValue: 1.13),
    ChartSampleData(x: DateTime(2015, 2), yValue: 1.12),
    ChartSampleData(x: DateTime(2015, 3), yValue: 1.08),
    ChartSampleData(x: DateTime(2015, 4), yValue: 1.12),
    ChartSampleData(x: DateTime(2015, 5), yValue: 1.1),
    ChartSampleData(x: DateTime(2015, 6), yValue: 1.12),
    ChartSampleData(x: DateTime(2015, 7), yValue: 1.1),
    ChartSampleData(x: DateTime(2015, 8), yValue: 1.12),
    ChartSampleData(x: DateTime(2015, 9), yValue: 1.12),
    ChartSampleData(x: DateTime(2015, 10), yValue: 1.1),
    ChartSampleData(x: DateTime(2015, 11), yValue: 1.06),
    ChartSampleData(x: DateTime(2015, 12), yValue: 1.09),
    ChartSampleData(x: DateTime(2016), yValue: 1.09),
    ChartSampleData(x: DateTime(2016, 2), yValue: 1.09),
    ChartSampleData(x: DateTime(2016, 3), yValue: 1.14),
    ChartSampleData(x: DateTime(2016, 4), yValue: 1.14),
    ChartSampleData(x: DateTime(2016, 5), yValue: 1.12),
    ChartSampleData(x: DateTime(2016, 6), yValue: 1.11),
    ChartSampleData(x: DateTime(2016, 7), yValue: 1.11),
    ChartSampleData(x: DateTime(2016, 8), yValue: 1.11),
    ChartSampleData(x: DateTime(2016, 9), yValue: 1.12),
    ChartSampleData(x: DateTime(2016, 10), yValue: 1.1),
    ChartSampleData(x: DateTime(2016, 11), yValue: 1.08),
    ChartSampleData(x: DateTime(2016, 12), yValue: 1.05),
    ChartSampleData(x: DateTime(2017), yValue: 1.08),
    ChartSampleData(x: DateTime(2017, 2), yValue: 1.06),
    ChartSampleData(x: DateTime(2017, 3), yValue: 1.07),
    ChartSampleData(x: DateTime(2017, 4), yValue: 1.09),
    ChartSampleData(x: DateTime(2017, 5), yValue: 1.12),
    ChartSampleData(x: DateTime(2017, 6), yValue: 1.14),
    ChartSampleData(x: DateTime(2017, 7), yValue: 1.17),
    ChartSampleData(x: DateTime(2017, 8), yValue: 1.18),
    ChartSampleData(x: DateTime(2017, 9), yValue: 1.18),
    ChartSampleData(x: DateTime(2017, 10), yValue: 1.16),
    ChartSampleData(x: DateTime(2017, 11), yValue: 1.18),
    ChartSampleData(x: DateTime(2017, 12), yValue: 1.2),
    ChartSampleData(x: DateTime(2018), yValue: 1.25),
    ChartSampleData(x: DateTime(2018, 2), yValue: 1.22),
    ChartSampleData(x: DateTime(2018, 3), yValue: 1.23),
    ChartSampleData(x: DateTime(2018, 4), yValue: 1.21),
    ChartSampleData(x: DateTime(2018, 5), yValue: 1.17),
    ChartSampleData(x: DateTime(2018, 6), yValue: 1.17),
    ChartSampleData(x: DateTime(2018, 7), yValue: 1.17),
    ChartSampleData(x: DateTime(2018, 8), yValue: 1.17),
    ChartSampleData(x: DateTime(2018, 9), yValue: 1.16),
    ChartSampleData(x: DateTime(2018, 10), yValue: 1.13),
    ChartSampleData(x: DateTime(2018, 11), yValue: 1.14),
    ChartSampleData(x: DateTime(2018, 12), yValue: 1.15)
  ];

  SfCartesianChart _buildDefaultDateTimeAxisChart() {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis:
            const DateTimeAxis(majorGridLines: MajorGridLines(width: 0)),
        primaryYAxis: const NumericAxis(
          minimum: 1,
          maximum: 1.35,
          interval: 0.05,
          labelFormat: r'${value}',
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0),
        ),
        series: _getDefaultDateTimeSeries(),
        trackballBehavior: _trackballBehavior);
  }

  List<SplineAreaSeries<ChartSampleData, DateTime>>
      _getDefaultDateTimeSeries() {
    return <SplineAreaSeries<ChartSampleData, DateTime>>[
      SplineAreaSeries<ChartSampleData, DateTime>(
          dataSource: data,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.yValue,
          color: context.colorScheme.primary.withOpacity(0.5))
    ];
  }
}

class ChartSampleData {
  final DateTime x;

  final double yValue;
  ChartSampleData({
    required this.x,
    required this.yValue,
  });
}