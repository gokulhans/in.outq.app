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

class ServiceWiseAnalytics extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ServiceWiseAnalytics({Key? key}) : super(key: key);

  @override
  ServiceWiseAnalyticsState createState() => ServiceWiseAnalyticsState();
}

class ServiceWiseAnalyticsState extends State<ServiceWiseAnalytics> {
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
      _future = http
          .get(Uri.parse('${apidomain}dashboard/analytics/services/$storeid'));
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
          title: "Service Wise Analytics",
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
                        // graphdata = [
                        //   _SalesData('Yester Day', data["y"].toDouble()),
                        //   _SalesData('Today', data["t"].toDouble()),
                        // ];

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
                            addVerticalSpace(20),
                            Text('Service Order Details',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                    color: ColorConstants.textclrw)),
                            addVerticalSpace(20),
                            Center(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, i) {
                                  return Container(
                                    padding: EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(
                                        left: 2, right: 2, top: 5, bottom: 5),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.appbgclr2,
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey.withOpacity(0.5),
                                      //     spreadRadius: 1,
                                      //     blurRadius: 3,
                                      //     offset: Offset(0,
                                      //         3), // changes position of shadow
                                      //   ),
                                      // ],
                                      borderRadius: BorderRadius.circular(10),
                                      // border: Border.all(
                                      //   color: Colors.black,
                                      //   width: 0,
                                      // ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data[i]["name"],
                                          style: GoogleFonts.montserrat(
                                            color: ColorConstants.textclr,
                                            fontSize: 16,
                                            // height: 1.5,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        addHorizontalSpace(15),
                                        Text(
                                          data[i]["count"].toString(),
                                          style: GoogleFonts.montserrat(
                                            color: Colors.green,
                                            fontSize: 16,
                                            // height: 1.5,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
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
