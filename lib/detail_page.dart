import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class stock {
  String date;
  String tradeCode;
  String high;
  String low;
  String open;
  String close;
  String volume;

  stock(this.date, this.tradeCode, this.high, this.low, this.open, this.close,
      this.volume);
}

class DetailPage extends StatelessWidget {
  final data;
  final details;
  DetailPage({Key key, this.data, this.details}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    // lists of stock data model
    List<stock> lists = getChartData(newList());
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          appBar: AppBar(
            elevation: 0.1,
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            title: Column(
              children: <Widget>[
                Positioned(
                  left: 8.0,
                  top: 60.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
              Center(
                child: Text(
                  data,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45.0,
                  ),
                ),
              ),
              SizedBox(height: queryData.size.height / 8),
              Container(
                child: SfTheme(
                  data: SfThemeData(
                    brightness: Brightness.dark,
                  ),
                  child: SfCartesianChart(
                    tooltipBehavior: TooltipBehavior(
                      enable: true,
                    ),
                    primaryXAxis: CategoryAxis(
                      title: AxisTitle(
                        text: 'Date',
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    primaryYAxis: NumericAxis(
                      title: AxisTitle(
                        text: 'Stocks',
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    legend: Legend(
                        isVisible: true,
                        toggleSeriesVisibility: true,
                        position: LegendPosition.bottom),
                    series: <ChartSeries>[
                      // Renders line chart
                      LineSeries<stock, String>(
                          dataSource: lists,
                          xValueMapper: (stock stocks, _) => stocks.date,
                          yValueMapper: (stock stocks, _) =>
                              double.parse(stocks.high.replaceAll(',', '')),
                          name: 'high'),
                      LineSeries<stock, String>(
                          dataSource: lists,
                          xValueMapper: (stock stocks, _) => stocks.date,
                          yValueMapper: (stock stocks, _) =>
                              double.parse(stocks.low.replaceAll(',', '')),
                          name: 'low'),
                      LineSeries<stock, String>(
                          dataSource: lists,
                          xValueMapper: (stock stocks, _) => stocks.date,
                          yValueMapper: (stock stocks, _) =>
                              double.parse(stocks.open.replaceAll(',', '')),
                          name: 'open'),
                      LineSeries<stock, String>(
                          dataSource: lists,
                          xValueMapper: (stock stocks, _) => stocks.date,
                          yValueMapper: (stock stocks, _) =>
                              double.parse(stocks.close.replaceAll(',', '')),
                          name: 'close'),
                      LineSeries<stock, String>(
                          dataSource: lists,
                          xValueMapper: (stock stocks, _) => stocks.date,
                          yValueMapper: (stock stocks, _) =>
                              double.parse(stocks.volume.replaceAll(',', '')) /
                              100000,
                          name: 'volume(100k)'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  //list of infos of only the selected company
  List newList() {
    var list = [];
    for (var i in details.value) {
      if (i['trade_code'] == data) {
        list.add(i);
      }
    }
    return list;
  }

  //convertion of list of map info to list of stock data model
  List<stock> getChartData(var list) {
    List<stock> chartData = [];
    for (var i in list) {
      stock data = stock(i['date'], i['trade_code'], i['high'], i['low'],
          i['open'], i['close'], i['volume']);
      chartData.add(data);
    }
    return chartData;
  }
}
