import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class LineSales {
  DateTime time;
  double sale;
  LineSales(this.time, this.sale);
}

Widget cddLineChart(List<LineSales> data) {
  List<LineSales> dataLine = data;

  var seriesLine = [
    charts.Series<LineSales, DateTime>(
      data: dataLine,
      domainFn: (LineSales lines, _) => lines.time,
      measureFn: (LineSales lines, _) => lines.sale,
      id: "Lines",
      seriesColor: charts.Color.black,
    )
  ];

  return charts.TimeSeriesChart(seriesLine);
}
