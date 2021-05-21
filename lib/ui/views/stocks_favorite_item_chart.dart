import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stocks_finance/repository/model/stock_trade.dart';

class StocksFavoriteItemChart extends StatefulWidget {
  final List<StockTrade> tradeList;
  final bool isUp;

  StocksFavoriteItemChart({required this.tradeList, required this.isUp});

  @override
  _StocksFavoriteItemChartState createState() =>
      _StocksFavoriteItemChartState();
}

class _StocksFavoriteItemChartState extends State<StocksFavoriteItemChart> {
  List<Color> upGradientColors = [
    const Color(0xff496ad0),
    const Color(0xff1343c9),
  ];

  List<Color> downGradientColors = [
    const Color(0xffcd5454),
    const Color(0xffcb1f1f),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: LineChart(mainData()),
      ),
    );
  }

  List<FlSpot> _getSpots() {
    List<FlSpot> spots = [];
    for (double index = 0; widget.tradeList.length > index; index++) {
      StockTrade trade = widget.tradeList.reversed.toList()[index.toInt()];
      spots.add(FlSpot(index, double.parse(trade.close!)));
    }
    return spots;
  }

  double _getMaxTradeValue() {
    double value = 0;
    for (double index = 0; widget.tradeList.length > index; index++) {
      StockTrade trade = widget.tradeList[index.toInt()];
      double close = double.parse(trade.close!);
      if(close > value) value = close;
    }
    return value;
  }

  double _getMinTradeValue() {
    double value = double.parse(widget.tradeList.first.close!)*100;
    for (double index = 0; widget.tradeList.length > index; index++) {
      StockTrade trade = widget.tradeList[index.toInt()];
      double close = double.parse(trade.close!);
      if(close < value) value = close;
    }
    return value;
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: widget.tradeList.length.toDouble(),
      minY: _getMinTradeValue(),
      maxY: _getMaxTradeValue(),
      lineBarsData: [
        LineChartBarData(
          spots: _getSpots(),
          isCurved: false,
          colors: widget.isUp ? upGradientColors : downGradientColors,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            colors: (widget.isUp ? upGradientColors : downGradientColors)
                .map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
