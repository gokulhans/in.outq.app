import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/components/placeholders/placeholder.dart';
import 'package:outq/screens/owner/components/appbar/owner_appbar.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ServiceViewAnalytics extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ServiceViewAnalytics({Key? key}) : super(key: key);

  @override
  ServiceViewAnalyticsState createState() => ServiceViewAnalyticsState();
}

class ServiceViewAnalyticsState extends State<ServiceViewAnalytics> {
  List<_SalesData> graphdata = [
    _SalesData('Yester Day', 3),
    _SalesData('Today', 5),
  ];

  Future<http.Response>? _future;
  var storeid;
  void onload() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    storeid = pref.getString("storeid");
    String date = DateTime.now().toString().split(' ')[0];
    String ydate = DateTime.now()
        .subtract(const Duration(days: 1))
        .toString()
        .split(' ')[0];
    setState(() {
      _future = http.get(
          Uri.parse('${apidomain}dashboard/analytics/$storeid/$date/$ydate'));
    });
  }

  @override
  void initState() {
    super.initState();
    onload();
    // print(_future);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.appbgclr,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: OwnerAppBarWithBack(
          title: "Service Click Analytics",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return FutureBuilder<http.Response>(
                    future: _future,
                    builder: (BuildContext context,
                        AsyncSnapshot<http.Response> snapshot) {
                      if (snapshot.hasData) {
                        var data = jsonDecode(snapshot.data!.body);
                        print(data);
                        graphdata = [
                          _SalesData('Yester Day', data["y"].toDouble()),
                          _SalesData('Today', data["t"].toDouble()),
                        ];

                        // return Expanded(
                        //   child: ListView.builder(
                        //     itemCount: data.length,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       return ListTile(
                        //         title: Text(data[index]['name']),
                        //       );
                        //     },
                        //   ),
                        // );
                        // return Text(data["t"].toString());
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                addVerticalSpace(20),
                                Text('Profile View Analatycs',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24,
                                        color: ColorConstants.textclrw)),
                                addVerticalSpace(20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    addVerticalSpace(10),
                                    Text(
                                      'Today',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.blue,
                                        fontSize: 14,
                                        // height: 1.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    addVerticalSpace(10),
                                    Text(
                                      data["t"].toString(),
                                      style: GoogleFonts.montserrat(
                                        color: ColorConstants.textclr,
                                        fontSize: 32,
                                        // height: 1.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                addVerticalSpace(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Yester Day',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.blue,
                                        fontSize: 14,
                                        // height: 1.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    addVerticalSpace(10),
                                    Text(
                                      data["y"].toString(),
                                      style: GoogleFonts.montserrat(
                                        color: ColorConstants.textclr,
                                        fontSize: 32,
                                        // height: 1.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                addVerticalSpace(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Growth Rate",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.blue,
                                        fontSize: 14,
                                        // height: 1.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    addVerticalSpace(10),
                                    (double.parse(data["growth"]) > 0)
                                        ? Text(
                                            "+${data["growth"].toString()} %",
                                            style: GoogleFonts.montserrat(
                                              color: Colors.green,
                                              fontSize: 25,
                                              // height: 1.5,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        : Text(
                                            "${data["growth"].toString()} %",
                                            style: GoogleFonts.montserrat(
                                              color: Colors.red,
                                              fontSize: 25,
                                              // height: 1.5,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),

                                    addVerticalSpace(20),
                                    // Initialize the chart widget
                                    Text('Today vs Yester Day',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: ColorConstants.textclr)),
                                    addVerticalSpace(20),
                                    Center(
                                      child: SizedBox(
                                        height: 150,
                                        child: SfCartesianChart(
                                          primaryXAxis:
                                              CategoryAxis(isVisible: false),
                                          // Chart title
                                          // title: ChartTitle(text: 'Today vs Yester Day',textStyle: TextStyle(fontWeight: FontWeight.w700)),
                                          // Enable legend
                                          // legend: Legend(isVisible: true),
                                          // Enable tooltip
                                          tooltipBehavior:
                                              TooltipBehavior(enable: true),
                                          series: <
                                              ChartSeries<_SalesData, String>>[
                                            LineSeries<_SalesData, String>(
                                                dataSource: graphdata,
                                                xValueMapper:
                                                    (_SalesData sales, _) =>
                                                        sales.year,
                                                yValueMapper:
                                                    (_SalesData sales, _) =>
                                                        sales.sales,
                                                name: 'Profile Views',
                                                color: Colors.black,
                                                // Enable data label
                                                dataLabelSettings:
                                                    DataLabelSettings(
                                                        isVisible: true,
                                                        textStyle: TextStyle(
                                                            color:
                                                                ColorConstants
                                                                    .green,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      } else if (snapshot.hasData) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Center(child: PlaceholderLong());
                      }
                    },
                  );
                }),

                // Expanded(
                //   flex: 2,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     //Initialize the spark charts widget
                //     child: SfSparkLineChart.custom(
                //       //Enable the trackball
                //       trackball: SparkChartTrackball(
                //           activationMode: SparkChartActivationMode.tap),
                //       //Enable marker
                //       marker: SparkChartMarker(
                //           displayMode: SparkChartMarkerDisplayMode.all),
                //       //Enable data label
                //       labelDisplayMode: SparkChartLabelDisplayMode.all,
                //       xValueMapper: (int index) => data[index].year,
                //       yValueMapper: (int index) => data[index].sales,
                //       dataCount: 2,
                //     ),
                //   ),
                // )
              ]),
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
